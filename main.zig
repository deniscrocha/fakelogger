const std = @import("std");
const log = @import("log.zig");
const util = @import("util.zig");
const DateTime = @import("time.zig").DateTime;
const Level = @import("log.zig").Level;

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    while (true) {
        gen_log(allocator);
        var timespec: std.posix.timespec = .{ .sec = 1, .nsec = 0 };
        _ = std.posix.system.nanosleep(&timespec, &timespec);
    }
}

fn gen_log(allocator: std.mem.Allocator) void {
    const dateTime: DateTime = DateTime.now();
    const isoDate: [] u8 = dateTime.toISO8601(allocator);
    defer allocator.free(isoDate);

    const level: Level =  log.gen_level();
    const message = level.get_random_message(allocator);
    defer allocator.free(message);

    std.debug.print("{s} [{s}] {s}\n", .{ isoDate, @tagName(level), message });
}
