const std = @import("std");

pub const DateTime = struct {
    year: i64,
    month: u8,
    day: u8,
    hour: u8,
    minute: u8,
    second: i64,

    pub fn printISO8601(this: DateTime) void {
        const allocator = std.heap.c_allocator;

        const buf = allocator.alloc(u8, 1024) catch {
            std.process.exit(1);
        };

        defer allocator.free(buf);

        buf[0] = @as(u8, @intCast('0' + @mod(@divTrunc(this.year, 1000), 10)));
        buf[1] = @as(u8, @intCast('0' + @mod(@divTrunc(this.year, 100), 10)));
        buf[2] = @as(u8, @intCast('0' + @mod(@divTrunc(this.year, 10), 10)));
        buf[3] = @as(u8, @intCast('0' + @mod(this.year, 10)));
        buf[4] = '-';

        buf[5] = @as(u8, @intCast('0' + @divTrunc(this.month, 10)));
        buf[6] = @as(u8, @intCast('0' + @mod(this.month, 10)));
        buf[7] = '-';

        buf[8] = @as(u8, @intCast('0' + @divTrunc(this.day, 10)));
        buf[9] = @as(u8, @intCast('0' + @mod(this.day, 10)));
        buf[10] = 'T';

        buf[11] = @as(u8, @intCast('0' + @divTrunc(this.hour, 10)));
        buf[12] = @as(u8, @intCast('0' + @mod(this.hour, 10)));
        buf[13] = ':';

        buf[14] = @as(u8, @intCast('0' + @divTrunc(this.minute, 10)));
        buf[15] = @as(u8, @intCast('0' + @mod(this.minute, 10)));
        buf[16] = ':';

        buf[17] = @as(u8, @intCast('0' + @divTrunc(this.second, 10)));
        buf[18] = @as(u8, @intCast('0' + @mod(this.second, 10)));
        buf[19] = 'Z';

        std.debug.print("{s}", .{buf});
    }

    pub fn now() DateTime {
        const ts: std.posix.timespec = std.posix.clock_gettime(std.posix.CLOCK.REALTIME) catch {
            std.process.exit(1);
        };
        const seconds = ts.sec;

        const sec_per_min = 60;
        const sec_per_hour = 60 * sec_per_min;
        const sec_per_day = 24 * sec_per_hour;

        const hour: u8 = utc_hour_to_sao_paulo(@divTrunc(@rem(seconds, sec_per_day), sec_per_hour));
        const minute: u8 = @intCast(@divTrunc(@rem(seconds, sec_per_hour), sec_per_min));
        const second: u8 = @intCast(@rem(seconds, sec_per_min));

        const epoch_days: u47 = @intCast(@divTrunc(seconds, sec_per_day));
        const epoch = std.time.epoch.EpochDay{ .day = epoch_days };

        const date = epoch.calculateYearDay();
        const is_leap = (date.year % 4 == 0) and ((@mod(date.year, 100) != 0) or (@mod(date.year, 400) == 0));

        const year: i64 = date.year;
        const month: u8 = get_month_number(date.day, is_leap);
        const day: u8 = get_day(date.day, is_leap);

        return DateTime{
            .year = year,
            .month = month,
            .day = day,
            .hour = hour,
            .minute = minute,
            .second = second,
        };
    }
};

fn get_month_number(day_of_year: u9, is_leap: bool) u8 {
    const month_lengths = if (is_leap)
        [_]u16{ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
    else
        [_]u16{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

    var acc: u16 = 0;

    for (month_lengths, 0..) |days, i| {
        acc += days;
        if (day_of_year <= acc) {
            return @intCast(i+1);
        }
    }

    // TODO: Talvez lançar uma exception aqui no futuro
    return 12;
}

fn get_day(day_of_year: u9, is_leap: bool) u8 {
    const month = get_month_number(day_of_year, is_leap);

    return @intCast(@divTrunc(day_of_year, month));
}

fn utc_hour_to_sao_paulo(utc: i64) u8 {
    if (utc >= 3) {
        return @intCast(utc - 3);
    }
    return @intCast((utc + 24) - 3);
}
