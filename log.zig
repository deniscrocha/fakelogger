const std = @import("std");
const util = @import("util.zig");
const time = @import("time.zig");

pub const Level = enum {
    FATAL,
    ERROR,
    WARNING,
    INFO,
    DEBUG,
    TRACE,

    pub fn get_random_message(this: Level, allocator: std.mem.Allocator) []u8 {
        const random = util.get_rand_number_max_five();

        return switch (this) {
            .FATAL => gen_fatal_log(random, allocator),
            .ERROR => gen_error_log(random, allocator),
            .WARNING => gen_warning_log(random, allocator),
            .INFO => gen_info_log(random, allocator),
            .DEBUG => gen_debug_log(random, allocator),
            .TRACE => gen_trace_log(random, allocator),
        };
    }
};

pub fn gen_level() Level {
    return @enumFromInt(util.get_rand_number_max_five());
}


fn gen_fatal_log(n: u32, allocator: std.mem.Allocator) [] u8 {
    const message: [] const u8 = switch (n) {
        0 => "Kernel panic — system halted.",
        1 => "Memory corruption detected.",
        2 => "Disk controller failure.",
        3 => "Unrecoverable segmentation fault.",
        4 => "Critical configuration missing.",
        5 => "Service crashed irreparably.",
        else => "Unknown fatal error.",
    };

    const message_size = message.len;
    const buf = allocator.alloc(u8, message_size) catch {
        std.debug.print("Cannot allocate memory", .{});
        std.posix.exit(1);
    };

    std.mem.copyForwards(u8, buf, message);
    return buf;
}

fn gen_error_log(n: u32, allocator: std.mem.Allocator) [] u8 {
    const message: []const u8 = switch (n) {
        0 => "Failed to process request.",
        1 => "Database connection timeout.",
        2 => "Invalid user input.",
        3 => "Write operation failed.",
        4 => "Unable to allocate resource.",
        5 => "Missing required file.",
        else => "Unknown error.",
    };

    const message_size = message.len;
    const buf = allocator.alloc(u8, message_size) catch {
        std.debug.print("Cannot allocate memory", .{});
        std.posix.exit(1);
    };

    std.mem.copyForwards(u8, buf, message);
    return buf;
}

fn gen_warning_log(n: u32, allocator: std.mem.Allocator) [] u8 {
    const message: []const u8 = switch (n) {
        0 => "High memory usage detected.",
        1 => "Network latency above normal.",
        2 => "Low disk space.",
        3 => "Deprecated API in use.",
        4 => "Configuration value near limit.",
        5 => "Retry attempt triggered.",
        else => "Unknown warning.",
    };

    const message_size = message.len;
    const buf = allocator.alloc(u8, message_size) catch {
        std.debug.print("Cannot allocate memory", .{});
        std.posix.exit(1);
    };

    std.mem.copyForwards(u8, buf, message);
    return buf;
}

fn gen_info_log(n: u32, allocator: std.mem.Allocator) [] u8 {
    const message: []const u8 = switch (n) {
        0 => "User logged in successfully.",
        1 => "Scheduled task executed.",
        2 => "Cache warmed up.",
        3 => "Background worker started.",
        4 => "Connection established.",
        5 => "Operation completed.",
        else => "General informational event.",
    };

    const message_size = message.len;
    const buf = allocator.alloc(u8, message_size) catch {
        std.debug.print("Cannot allocate memory", .{});
        std.posix.exit(1);
    };

    std.mem.copyForwards(u8, buf, message);
    return buf;
}

fn gen_debug_log(n: u32, allocator: std.mem.Allocator) [] u8 {
    const message: []const u8 = switch (n) {
        0 => "Checking internal buffer state.",
        1 => "Entering request handler.",
        2 => "Loop iteration step executed.",
        3 => "Memory allocation stats reviewed.",
        4 => "Parsing incoming payload.",
        5 => "Debug value updated.",
        else => "Generic debug event.",
    };

    const message_size = message.len;
    const buf = allocator.alloc(u8, message_size) catch {
        std.debug.print("Cannot allocate memory", .{});
        std.posix.exit(1);
    };

    std.mem.copyForwards(u8, buf, message);
    return buf;
}

fn gen_trace_log(n: u32, allocator: std.mem.Allocator) [] u8 {
    const message: []const u8 = switch (n) {
        0 => "Function entry.",
        1 => "Function exit.",
        2 => "Variable mutation tracepoint.",
        3 => "I/O event received.",
        4 => "Scheduler tick fired.",
        5 => "Code path visited.",
        else => "Generic trace event.",
    };

    const message_size = message.len;
    const buf = allocator.alloc(u8, message_size) catch {
        std.debug.print("Cannot allocate memory", .{});
        std.posix.exit(1);
    };

    std.mem.copyForwards(u8, buf, message);
    return buf;
}
