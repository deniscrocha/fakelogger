const std = @import("std");

pub fn get_rand_number_max_five() u32 {
    const n: u32 = get_rand_int();

    return n % 6;
}

pub fn get_rand_int() u32 {
    var buf: [4]u8 = undefined;
    std.crypto.random.bytes(&buf);
    const n: u32 =
        (cast_int(buf[0])) |
        (cast_int(buf[1]) << 8) |
        (cast_int(buf[2]) << 16) |
        (cast_int(buf[3]) << 24);

    return n;
}

fn cast_int(foo: u8) u32 {
    return @intCast(foo);
}
