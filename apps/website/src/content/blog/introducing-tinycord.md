---
title: 'Introducing Tinycord'
description: 'Why Tinycord exists, why it is written in Zig, and what it is trying to improve.'
pubDate: 'May 30 2026'
---

I built Tinycord because Discord's desktop client kept feeling heavier than the problem it solves.

The official app is Electron-based, which means it ships a full Chromium runtime to display what is, at its core, a web app. That comes with real costs: more disk usage, more memory pressure, a larger attack surface, and more complexity when all you want is a chat window that stays out of the way.

There are already good alternatives. [Vesktop](https://github.com/Vencord/Vesktop) improves the experience and gives people a faster-moving client with Vencord support. [Dorion](https://spikehd.dev/projects/dorion/) takes a different route with Tauri and native webviews. Both are solid projects, and both validated the basic idea: Discord does not need to be wrapped in a heavyweight desktop shell to be usable.

Tinycord is my answer to a narrower question: what is the smallest, cleanest desktop wrapper that still feels native?

The answer I landed on was Zig. Zig gives me direct control over the build, a small runtime story, and a codebase that stays close to the metal without forcing me into a large framework. That matters here because the app does not need much logic at all. It needs to create a native window, embed the platform webview, load `discord.com/app`, and handle the small amount of glue code that makes that work across platforms.

That is the entire core concept. The app logic is only a few dozen lines of Zig, plus a tiny Objective-C helper for macOS media permissions. The result is a binary under 5 MB, with no bundled browser, no Electron, and no framework layer sitting between the user and the OS.

That constraint is the point. Fewer moving parts means less memory usage, a smaller attack surface, and fewer ways for the desktop wrapper itself to get in the way. Tinycord does not inject into Discord, add client mods, or try to reinvent the app. It is intentionally boring: a native window that loads Discord and gets out of the way.

That said, it is not the finished version of the idea. The current backlog includes native notifications, telemetry blocking, tray behavior, and the rough edges that come with making a tiny cross-platform app feel polished. The foundation is there, though, and the current build is already usable for everyday Discord use, including voice calls.

If you want to follow along, the source code is on the [GitHub repo](https://github.com/ilyeshdz/tinycord), and the prebuilt binaries are on the [download page](/download). Tinycord is MIT licensed, and contributions are welcome.
