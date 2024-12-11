const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const cexception_dep = b.dependency("CException", .{});
    const cexception_lib= b.addStaticLibrary(.{
        .name = "CException",
        .target = target,
        .optimize = optimize,
    });

    cexception_lib.addIncludePath(cexception_dep.path("lib"));
    cexception_lib.addCSourceFile(.{
        .file = cexception_dep.path("lib/CException.c"),
        .flags = &[_][] const u8{"-Werror","-std=c11"},
    });
    cexception_lib.linkLibC();

    b.installArtifact(cexception_lib);

    //const lib_unit_tests = b.addExecutable(.{
    //    .name = "test",
    //    .target = target,
    //    .optimize = optimize,
    //});
    //lib_unit_tests.addIncludePath(cexception_dep.path("test/support"));
    //lib_unit_tests.addCSourceFile(.{
    //    .file = cexception_dep.path("test/TestException.c"),
    //    .flags = &[_][] const u8{"-std=c11"},
    //});
    //lib_unit_tests.linkLibrary(cexception_lib);

    //const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    //const test_step = b.step("test", "Run unit tests");
    //test_step.dependOn(&run_lib_unit_tests.step);
}
