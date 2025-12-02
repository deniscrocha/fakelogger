const std = @import("std");
const util = @import("util.zig");
const time = @import("time.zig");

const log_level = enum {
    FATAL,
    ERROR,
    WARNING,
    INFO,
    DEBUG,
    TRACE
};

pub fn gen_log() void {
    const level = get_log_level(util.get_rand_number_max_five());
    get_text_from_level(level);
}

fn get_log_level(n: u32) log_level {
    const level: log_level = @enumFromInt(n);
    return level;
}

fn get_text_from_level(level: log_level) void {
    const random = util.get_rand_number_max_five();

    return switch (level) {
        .FATAL => gen_fatal_log(random),
        .ERROR => gen_error_log(random),
        .WARNING => gen_warning_log(random),
        .INFO => gen_info_log(random),
        .DEBUG => gen_debug_log(random),
        .TRACE => gen_trace_log(random),
    };
}

fn format_log(level: []const u8, message: []const u8) void {
    time.DateTime.now()
        .printISO8601();

    std.debug.print(" [{s}] {s}\n", .{level, message});
}

fn gen_fatal_log(n: u32) void {
    const msg = switch (n) {
        0 => "Kernel panic — system halted.",
        1 => "Memory corruption detected.",
        2 => "Disk controller failure.",
        3 => "Unrecoverable segmentation fault.",
        4 => "Critical configuration missing.",
        5 => "Service crashed irreparably.",
        else => "Unknown fatal error.",
    };
    format_log("FATAL", msg);
}

fn gen_error_log(n: u32) void {
    const msg = switch (n) {
        0 => "Failed to process request.",
        1 => "Database connection timeout.",
        2 => "Invalid user input.",
        3 => "Write operation failed.",
        4 => "Unable to allocate resource.",
        5 => "Missing required file.",
        else => "Unknown error.",
    };
    format_log("ERROR", msg);
}

fn gen_warning_log(n: u32) void {
    const msg = switch (n) {
        0 => "High memory usage detected.",
        1 => "Network latency above normal.",
        2 => "Low disk space.",
        3 => "Deprecated API in use.",
        4 => "Configuration value near limit.",
        5 => "Retry attempt triggered.",
        else => "Unknown warning.",
    };
    format_log("WARN", msg);
}

fn gen_info_log(n: u32) void {
    const msg = switch (n) {
        0 => "User logged in successfully.",
        1 => "Scheduled task executed.",
        2 => "Cache warmed up.",
        3 => "Background worker started.",
        4 => "Connection established.",
        5 => "Operation completed.",
        else => "General informational event.",
    };
    format_log("INFO", msg);
}

fn gen_debug_log(n: u32) void {
    const msg = switch (n) {
        0 => "Checking internal buffer state.",
        1 => "Entering request handler.",
        2 => "Loop iteration step executed.",
        3 => "Memory allocation stats reviewed.",
        4 => "Parsing incoming payload.",
        5 => "Debug value updated.",
        else => "Generic debug event.",
    };
    format_log("DEBUG", msg);
}

fn gen_trace_log(n: u32) void {
    const msg = switch (n) {
        0 => "Function entry.",
        1 => "Function exit.",
        2 => "Variable mutation tracepoint.",
        3 => "I/O event received.",
        4 => "Scheduler tick fired.",
        5 => "Code path visited.",
        else => "Generic trace event.",
    };
    format_log("TRACE", msg);
}
