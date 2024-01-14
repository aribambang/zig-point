const std = @import("std");

// You can return a struct from a function. This is how we do generics in Zig
pub fn Point(comptime T: type) type {
    return struct {
        const Self = @This();

        X: T = 0,
        Y: T = 0,

        pub fn init() Self {
            return Self{
                .X = 0,
                .Y = 0,
            };
        }

        pub fn makePoint(newX: T, newY: T) Self {
            var p: Self = undefined;

            setX(&p, newX);
            setY(&p, newY);

            return p;
        }

        pub fn printPoint(self: Self) void {
            std.debug.print("({},{})\n", .{ getX(self), getY(self) });
        }

        pub fn setX(self: *Self, newX: T) void {
            self.X = newX;
        }

        pub fn setY(self: *Self, newY: T) void {
            self.Y = newY;
        }

        pub fn getX(self: Self) T {
            return self.X;
        }

        pub fn getY(self: Self) T {
            return self.Y;
        }
    };
}

test "makePoint" {
    const T: type = i32;
    var p = Point(T).makePoint(1, 2);

    try std.testing.expect(p.X == 1);
    try std.testing.expect(p.Y == 2);
}
