const std = @import("std");

pub fn main() !void {
    const image_width = 256;
    const image_height = 256;

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("P3\n{} {}\n255\n", .{ image_width, image_height });

    for (0..image_height) |j| {
        for (0..image_width) |i| {
            const r = @as(f32, @floatFromInt(i)) / @as(f32, image_width - 1);
            const g = @as(f32, @floatFromInt(j)) / @as(f32, image_height - 1);
            const b = 0.0;

            const ir = @as(u8, @intFromFloat(255.999 * r));
            const ig = @as(u8, @intFromFloat(255.999 * g));
            const ib = @as(u8, @intFromFloat(255.999 * b));

            try stdout.print("{} {} {}\n", .{ ir, ig, ib });
        }
    }

    try bw.flush();
}
