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

        pub fn assignPoint(p: Self) Self {
            return makePoint(getX(p), getY(p));
        }

        pub fn printPoint(self: Self) void {
            std.debug.print("({},{})\n", .{ getX(self), getY(self) });
        }

        pub fn plusPoint(p1: Self, p2: Self) Self {
            return makePoint(getX(p1) + getX(p2), getY(p1) + getY(p2));
        }

        pub fn pointEqual(p1: Self, p2: Self) bool {
            return (getX(p1) == getX(p2) and getY(p1) == getY(p2));
        }

        pub fn isOrigin(p: Self) bool {
            return (getX(p) == 0 and getY(p) == 0);
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

test "init" {
    const T: type = i32;
    var p = Point(T).init();

    try std.testing.expect(p.X == 0);
    try std.testing.expect(p.Y == 0);
}

test "makePoint" {
    const T: type = i32;
    var p = Point(T).makePoint(1, 2);

    try std.testing.expect(p.X == 1);
    try std.testing.expect(p.Y == 2);
}

test "pointEqual" {
    const T: type = i32;
    var p1 = Point(T).makePoint(1, 2);
    var p2 = Point(T).makePoint(1, 2);

    try std.testing.expect(Point(T).pointEqual(p1, p2) == true);
}

test "plusPoint" {
    const T: type = i32;
    var p1 = Point(T).makePoint(1, 2);
    var p2 = Point(T).makePoint(1, 2);
    var p3 = Point(T).plusPoint(p1, p2);

    try std.testing.expect(p3.X == 2);
    try std.testing.expect(p3.Y == 4);
}

test "isOrigin" {
    const T: type = i32;
    var p = Point(T).init();

    try std.testing.expect(Point(T).isOrigin(p) == true);
}
