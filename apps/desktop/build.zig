const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "tinycord",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const webview_dep = b.dependency("webview", .{
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("webview", webview_dep.module("webview"));

    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_exe.step);

    const install_artifact = b.addInstallArtifact(exe, .{});
    b.getInstallStep().dependOn(&install_artifact.step);

    const app_step = b.step("app", "Build the app");
    const bundle = makeAppBundle(b, exe, "assets/icon.icns");
    app_step.dependOn(bundle);
}

fn makeAppBundle(
    b: *std.Build,
    exe: *std.Build.Step.Compile,
    icon_path: []const u8,
) *std.Build.Step {
    const write_files = b.addWriteFiles();

    const plist =
        \\<?xml version="1.0" encoding="UTF-8"?>
        \\<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        \\<plist version="1.0">
        \\<dict>
        \\    <key>CFBundleDevelopmentRegion</key>
        \\    <string>en</string>
        \\    <key>CFBundleExecutable</key>
        \\    <string>tinycord</string>
        \\    <key>CFBundleIdentifier</key>
        \\    <string>com.example.tinycord</string>
        \\    <key>CFBundleInfoDictionaryVersion</key>
        \\    <string>6.0</string>
        \\    <key>CFBundleName</key>
        \\    <string>Tinycord</string>
        \\    <key>CFBundlePackageType</key>
        \\    <string>APPL</string>
        \\    <key>CFBundleShortVersionString</key>
        \\    <string>0.1.0</string>
        \\    <key>CFBundleVersion</key>
        \\    <string>1</string>
        \\    <key>LSMinimumSystemVersion</key>
        \\    <string>12.0</string>
        \\    <key>NSHighResolutionCapable</key>
        \\    <true/>
        \\    <key>CFBundleIconFile</key>
        \\    <string>icon.icns</string>
        \\</dict>
        \\</plist>
    ;

    const plist_file = write_files.add("Info.plist", plist);

    const plist_install = b.addInstallFileWithDir(
        plist_file,
        .{ .custom = "Tinycord.app/Contents" },
        "Info.plist",
    );

    const icon_install = b.addInstallFileWithDir(
        b.path(icon_path),
        .{ .custom = "Tinycord.app/Contents/Resources" },
        "icon.icns",
    );

    const exe_install = b.addInstallArtifact(exe, .{
        .dest_dir = .{ .override = .{ .custom = "Tinycord.app/Contents/MacOS" } },
    });

    const bundle_step = b.step("bundle-app", "Bundle macOS app");

    bundle_step.dependOn(&write_files.step);
    bundle_step.dependOn(&plist_install.step); // Make sure the install step runs!
    bundle_step.dependOn(&icon_install.step);
    bundle_step.dependOn(&exe_install.step);

    return bundle_step;
}
