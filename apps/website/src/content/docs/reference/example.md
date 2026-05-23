---
title: Architecture
description: How it works
---

## Core

`src/main.zig` creates a webview and loads Discord:

```zig
const w = try Webview.create(true, null);
try w.setTitle("Tinycord");
try w.setSize(800, 600, .none);
try w.navigate("https://discord.com/app");
try w.run();
```

[zig-webview](https://github.com/happystraw/zig-webview) abstracts the platform engine:

| Platform | Engine |
|---|---|
| Linux | WebKitGTK |
| macOS | WKWebView |
| Windows | WebView2 |

## macOS permissions

`src/macos/media.m` auto-grants camera and microphone access using Objective-C runtime APIs. Also sets a Chrome 131 user agent for Discord compatibility. Compiled only on macOS:

```zig
if (target.result.os.tag == .macos) {
    exe.root_module.addCSourceFile(.{
        .file = b.path("src/macos/media.m"),
        .flags = &.{"-fobjc-arc"},
    });
    exe.root_module.linkFramework("CoreFoundation", .{});
}
```

## Dependencies

| Dependency | Role |
|---|---|
| [zig-webview](https://github.com/happystraw/zig-webview) | Cross-platform WebView bindings |
