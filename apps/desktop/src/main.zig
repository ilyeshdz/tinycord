const std = @import("std");
const builtin = @import("builtin");
const Webview = @import("webview").Webview;

extern fn setup_webview_media(webview: *anyopaque) void;

pub fn main() !void {
    const w = try Webview.create(true, null);
    defer w.destroy() catch unreachable;
    try w.setTitle("Tinycord");
    try w.setSize(800, 600, .none);

    if (builtin.os.tag == .macos) {
        if (w.getNativeHandle(.browser_controller)) |handle| {
            setup_webview_media(handle);
        }
    }

    try w.navigate("https://discord.com/app");
    try w.run();
}
