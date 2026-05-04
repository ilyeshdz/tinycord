import { constants as fsConstants } from "node:fs";
import { access, mkdir, readFile, stat, writeFile } from "node:fs/promises";
import { spawn } from "node:child_process";
import { dirname, resolve } from "node:path";
import process from "node:process";

const root = resolve(new URL("..", import.meta.url).pathname);
const clientDir = resolve(root, "packages/client");
const clientBundle = resolve(clientDir, "dist/browser.js");
const clientStyles = resolve(clientDir, "dist/browser.css");
const generatedClient = resolve(root, "packages/app/src/generated/client.js");
const isDev = process.argv.includes("--dev");

const env = {
  ...process.env,
  VENCORD_HASH: process.env.VENCORD_HASH ?? (isDev ? "tinycord-dev" : "tinycord"),
  VENCORD_REMOTE: process.env.VENCORD_REMOTE ?? "tinycord/tinycord"
};

function run(command, args, options = {}) {
  return new Promise((resolveRun, reject) => {
    const child = spawn(command, args, {
      cwd: options.cwd ?? root,
      env,
      stdio: options.stdio ?? "inherit"
    });

    child.on("error", reject);
    child.on("exit", code => {
      if (code === 0) resolveRun();
      else reject(new Error(`${command} ${args.join(" ")} exited with code ${code}`));
    });
  });
}

function start(command, args, options = {}) {
  const child = spawn(command, args, {
    cwd: options.cwd ?? root,
    env,
    stdio: "inherit"
  });

  child.on("exit", code => {
    if (code && !options.allowExit) process.exitCode = code;
  });

  return child;
}

async function exists(path) {
  return access(path, fsConstants.F_OK)
    .then(() => true)
    .catch(() => false);
}

async function waitForFile(path, timeoutMs = 60_000) {
  const startedAt = Date.now();

  while (!await exists(path)) {
    if (Date.now() - startedAt > timeoutMs) {
      throw new Error(`Timed out waiting for ${path}`);
    }

    await new Promise(resolveWait => setTimeout(resolveWait, 250));
  }
}

function buildInjectedClient(bundle, styles) {
  return `(() => {
  const css = ${JSON.stringify(styles)};
  const applyBaseBackground = () => {
    document.documentElement.style.backgroundColor = "#313338";
    if (document.body) document.body.style.backgroundColor = "#313338";
  };
  const installStyles = () => {
    applyBaseBackground();
    const root = document.head || document.documentElement;
    if (!root || document.getElementById("tinycord-client-css")) return;
    const style = document.createElement("style");
    style.id = "tinycord-client-css";
    style.textContent = css;
    root.appendChild(style);
  };

  installStyles();
  document.addEventListener("DOMContentLoaded", installStyles, { once: true });
})();

${bundle}`;
}

async function copyClientBundle() {
  const [bundle, styles] = await Promise.all([
    readFile(clientBundle, "utf-8"),
    readFile(clientStyles, "utf-8")
  ]);

  await mkdir(dirname(generatedClient), { recursive: true });
  await writeFile(generatedClient, buildInjectedClient(bundle, styles));
  console.info(`Generated ${generatedClient}`);
}

async function watchClientBundle() {
  let lastBundleMtime = 0;
  let lastStylesMtime = 0;

  setInterval(async () => {
    try {
      const [currentBundle, currentStyles] = await Promise.all([
        stat(clientBundle),
        stat(clientStyles)
      ]);

      if (currentBundle.mtimeMs !== lastBundleMtime || currentStyles.mtimeMs !== lastStylesMtime) {
        lastBundleMtime = currentBundle.mtimeMs;
        lastStylesMtime = currentStyles.mtimeMs;
        await copyClientBundle();
      }
    } catch {
      // The client build may briefly remove or replace dist/browser.js.
    }
  }, 500);
}

if (isDev) {
  const client = start("pnpm", ["--dir", "packages/client", "buildWeb", "--skip-extension", "--watch", "--dev"]);
  await waitForFile(clientBundle);
  await copyClientBundle();
  await watchClientBundle();

  const app = start("pnpm", ["--filter", "@tinycord/app", "tauri", "dev"]);

  for (const signal of ["SIGINT", "SIGTERM"]) {
    process.on(signal, () => {
      client.kill(signal);
      app.kill(signal);
    });
  }
} else {
  await run("pnpm", ["--dir", "packages/client", "buildWeb", "--skip-extension"]);
  await copyClientBundle();
  await run("pnpm", ["--filter", "@tinycord/app", "tauri", "build"]);
}
