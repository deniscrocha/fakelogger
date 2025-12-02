const std = @import("std");
const log_message = @import("log_message.zig");
const util = @import("util.zig");

pub fn main() !void {
    while (true) {
        log_message.gen_log();
        var timespec: std.posix.timespec = .{ .sec = 1, .nsec = 0 };
        _ = std.posix.system.nanosleep(&timespec, &timespec);
    }
}
