const std = @import("std");

inline fn ensureVector(comptime T: type) type {
    if (@typeInfo(T) != .Vector) {
        @compileError("ensureVector: type is not a vector");
    }
    return T;
}

pub inline fn vsize(comptime T: type) comptime_int {
    _ = ensureVector(T);
    return @typeInfo(T).Vector.len;
}

pub inline fn value_type(comptime T: type) type {
    _ = ensureVector(T);
    return @typeInfo(T).Vector.child;
}

pub inline fn dot(v1: anytype, v2: anytype) value_type(@TypeOf(v1)) {
    const vt1 = ensureVector(v1);
    const vt2 = ensureVector(v2);
    if (vt1 != vt2) {
        @compileError("dot: vectors must be of the same type");
    }
    return @reduce(.Add, v1 * v2);
}

pub inline fn length(v: anytype) value_type(@TypeOf(v)) {
    _ = ensureVector(v);
    return std.math.sqrt(length_squared(v));
}

pub inline fn length_squared(v: anytype) value_type(@TypeOf(v)) {
    _ = ensureVector(v);
    return @reduce(.Add, v * v);
}

pub inline fn cross(v1: anytype, v2: anytype) value_type(@TypeOf(v1)) {
    const vt1 = ensureVector(v1);
    const vt2 = ensureVector(v2);
    if (vt1 != vt2) {
        @compileError("dot: vectors must be of the same type");
    }
    return vt1{
        v1[1] * v2[2] - v1[2] * v2[1],
        v1[2] * v2[0] - v1[0] * v2[2],
        v1[0] * v2[1] - v1[1] * v2[0],
    };
}

pub inline fn unit_vector(v: anytype) value_type(@TypeOf(v)) {
    _ = ensureVector(v);
    return v / v.length();
}
