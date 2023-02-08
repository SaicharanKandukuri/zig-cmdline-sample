// test implementation to read cmd line arguments in zig
// Authored by: @SaicharanKandukuri

const std = @import("std");
const fmt = std.fmt;
const writer = std.io.getStdOut().writer();

pub var version:    [:0]const u8 = "0.0.1";
pub var projName:   [:0]const u8 = "Zig CLI arguments test | ";
pub var printArgs:  bool         = false;

/// custom equal implementation

pub fn isEqual(comptime T: type, a: []const T , b: []const T ) bool {
    // compare the length of the arrays. If they are not the same, the arrays are not equal.
    // If the length of the arrays is the same, we check if the pointers are the same. If they are, the arrays are equal.
    // If the pointers are not the same, we iterate over the first array and compare the elements of the first array to the elements of the second array. If they are not equal, the arrays are not equal. If they are equal, we continue iterating over the first array. If all the elements are equal, the arrays are equal

    if (a.len != b.len) return false;
    if (a.ptr == b.ptr) return true;
    for (a) | elem , index | {
        if (b[index] != elem) return false;   
    }

    return true;
}

/// arg helper function to handle cmdline args
fn argHelper(comptime T: type, arg:[]const T) !bool {
    // Template
    // if (isEqual(T, arg, "<expected_arg>")) {
    //     <Your Code>
    //    return true;
    // }

    // --help
    if (isEqual(T, arg, "--help")) {
        // help function goes here
        try writer.print("help\n", .{});
        return true;
    }

    // 1
    if (isEqual(T, arg, "1")) {
        try writer.print("1\n", .{});
        return true;
    }

    // version
    if (isEqual(T, arg, "--version")) {
        try writer.print("{s} tool V{s}(C) 2023\n", .{projName,version});
        return true;
    }

    // print everything
    if (isEqual(T, arg, "--print-args")) {
        printArgs = true;
        return true;
    }

    // unknown arg
    try writer.print("unknown arg: {s}\n", .{arg});
    return false;
}

pub fn main() !void {
    var args = std.process.args();
    var argn: u8 = 0;

    while (args.next()) |arg|: (argn += 1) {
        if (argn == 0) continue;

        if (printArgs) {
            // print all args
            try writer.print("{s}, ", .{arg});
            continue;
        }
        
        if (!try argHelper(u8, arg)) {
            std.os.exit(1);
        }
    }
}
