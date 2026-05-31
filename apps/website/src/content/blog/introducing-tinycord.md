---
title: 'Introducing Tinycord'
description: 'A lightweight Discord client built with Zig — no Electron, no bloat.'
pubDate: 'May 30 2026'
---

I've been thinking about Discord's desktop app for a while.

It's built on Electron, which means it essentially ships a full Chromium browser just to render a chat interface. You end up with around 200 MB taken up on your disk and hundreds of megabytes of RAM down the drain, all for what is basically just a web page.

People have built some solid alternatives to fix this. [Vesktop](https://github.com/Vencord/Vesktop) is a popular choice because it runs Discord's web app in a newer version of Electron than the official client and hooks up Vencord for client modding. While it runs better than stock Discord, it doesn't escape the underlying issue because it's still Electron and it's still shipping a browser.

Then you have projects like [Dorion](https://spikehd.dev/projects/dorion/), which uses Tauri. This is much closer to what I wanted since Tauri utilizes the system's native WebView instead of bundling Chromium. However, Tauri is built on Rust and brings its own framework overhead. It is definitely lighter than Electron, but it still feels like a lot of heavy machinery for a task as simple as opening a URL in a webview.

So, I decided to build Tinycord.

It is a straightforward Zig program that spins up a native WebView and loads `discord.com/app`. That is the entire core concept. It takes about 50 lines of Zig, a small Objective-C file to handle macOS media permissions, and spits out a binary under 5 MB. There is no Electron, no Tauri, and no framework overhead. It just lets the OS do what it does best.

The philosophy behind it is simple: the less code standing between you and Discord, the better. You get a smaller attack surface, lower memory usage, and fewer moving parts that can break. Tinycord does not add features, mod the client, or inject anything right now. It is quite literally just a window.

It is still early days, so I wouldn't call it fully stable yet. I have a backlog of things I want to implement, like native notifications, telemetry blocking, and tray behavior. That said, the foundation is solid, and it works perfectly fine for basic use, including voice calls.

If you want to check it out, the source code is up on the [GitHub repo](https://github.com/ilyeshdz/tinycord), and you can grab prebuilt binaries from the [download page](https://www.google.com/search?q=/download). It's MIT licensed, and contributions are always welcome.