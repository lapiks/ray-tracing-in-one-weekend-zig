const std = @import("std");
const color = @import("color.zig");

const Color = color.Color;

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    const stderr = std.io.getStdErr().writer();

    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const image_width = 256;
    const image_height = 256;

    try stdout.print("P3\n{} {}\n255\n", .{ image_width, image_height });

    for (0..image_height) |j| {
        try stderr.print("\rScanlines remaining: {}", .{image_height - j});

        for (0..image_width) |i| {
            const r = @as(f32, @floatFromInt(i)) / @as(f32, image_width - 1);
            const g = @as(f32, @floatFromInt(j)) / @as(f32, image_height - 1);
            const b = 0.0;

            const pixel_color = Color{ r, g, b };
            try color.write_color(stdout, pixel_color);
        }
    }

    try stderr.print("\rDone.                       \n", .{});
    try bw.flush();
}
