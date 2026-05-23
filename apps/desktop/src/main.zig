const std = @import("std");
const Webview = @import("webview").Webview;

pub fn main() !void {
    const w = try Webview.create(true, null);
    defer w.destroy() catch unreachable;
    try w.setTitle("Tinycord");
    try w.setSize(800, 600, .none);
    try w.navigate("https://discord.com/app");
    try w.run();
}
