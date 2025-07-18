const Vec3 = @import("vec.zig").Vec3;

pub const Color = Vec3;

pub fn write_color(stdout: anytype, color: Color) !void {
    const ir = @as(u8, @intFromFloat(255.999 * color[0]));
    const ig = @as(u8, @intFromFloat(255.999 * color[1]));
    const ib = @as(u8, @intFromFloat(255.999 * color[2]));

    try stdout.print("{} {} {}\n", .{ ir, ig, ib });
}
