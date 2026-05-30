---
title: 'Introducing Tinycord'
description: 'A secure and lightweight alternative to the official Discord client.'
pubDate: 'May 30 2026'
---

Today I'm releasing Tinycord -- a minimal alternative to the official Discord desktop client, built with Zig.

## The problem

The official Discord client is an Electron app. It bundles a full Chromium browser, takes ~200 MB on disk, and consumes significant memory even when idle. For a chat app, that's a lot of overhead.

## The approach

Tinycord uses your system's native WebView instead of bundling a browser:

- **macOS** -- WKWebView (Safari's engine)
- **Windows** -- WebView2 (Edge's engine)
- **Linux** -- WebKitGTK

The result is a binary under 5 MB that starts instantly and uses a fraction of the memory.

## Why Zig?

Zig is a small language with a simple toolchain. No hidden control flow, no GC, no heavy runtime. For a program whose core is "open a WebView and load a URL," Zig gets out of the way and lets the OS do the work.

The entire app is ~50 lines of Zig plus a small Objective-C file for macOS media permissions.

## Current status

Tinycord is **not stable yet**. It works for basic use -- browsing servers, sending messages, voice calls -- but it's missing several features I plan to add:

- Native OS notifications (requires JavaScript injection into the web app)
- Telemetry blocking (Discord's web app includes analytics that the desktop client normally strips)
- Proper tray/minimize-to-menu behavior
- Keyboard shortcut customization

### The injection plan

Discord's web app, like the desktop client, is essentially a web page. The official client injects JavaScript to add native features. Tinycord will do the same -- a small injected script that:

1. Intercepts Discord's notification API and routes it through native OS notifications
2. Blocks telemetry and analytics endpoints
3. Adds tray integration and custom shortcuts

This script will be minimal, open source, and auditable. No obfuscation, no tracking, no external network calls.

### Vencord and plugins

Longer term, I want to support loading [Vencord](https://vencord.dev) and other injectors. Since Tinycord is just a WebView, the injection mechanism is straightforward -- it's a matter of providing a stable API for third-party scripts to hook into the web app before Discord's code runs.

## What it is not

Tinycord does not modify Discord's interface, add features, block ads, or inject anything into the web app -- **yet**. Currently it is literally a WebView that loads `discord.com/app`. The injection system is planned but not implemented.

## What it is

A foundation. A minimal, auditable, native wrapper around Discord that can be extended with intent rather than bloat.

Check the [GitHub repo](https://github.com/ilyeshdz/tinycord) for source code and the [download page](/download) for prebuilt binaries.
