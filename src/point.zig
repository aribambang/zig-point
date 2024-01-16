const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;
const pow = std.math.pow;

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
            print("({},{})\n", .{ getX(self), getY(self) });
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

        pub fn quadrant(p: Self) i32 {
            const x = getX(p);
            const y = getY(p);

            if (x > 0 and y > 0) {
                return 1;
            } else if (x < 0 and y > 0) {
                return 2;
            } else if (x < 0 and y < 0) {
                return 3;
            } else if (x > 0 and y < 0) {
                return 4;
            } else {
                return undefined;
            }
        }

        pub fn midPoint(p1: Self, p2: Self) Self {
            return makePoint(@divExact((getX(p1) + getX(p2)), 2), @divExact((getY(p1) + getY(p2)), 2));
        }

        pub fn distanceFromZero(p: Self) f32 {
            return @sqrt(@as(f32, @floatFromInt(pow(T, getX(p), 2) + pow(T, getY(p), 2))));
        }

        pub fn distanceTwoPoint(p1: Self, p2: Self) f32 {
            return @sqrt(@as(f32, @floatFromInt(pow(T, getX(p1) - getX(p2), 2) + pow(T, getY(p1) - getY(p2), 2))));
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
    const p = Point(T).init();

    try expect(p.X == 0);
    try expect(p.Y == 0);
}

test "makePoint" {
    const T: type = i32;
    const p = Point(T).makePoint(1, 2);

    try expect(p.X == 1);
    try expect(p.Y == 2);
}

test "pointEqual" {
    const T: type = i32;
    const p1 = Point(T).makePoint(1, 2);
    const p2 = Point(T).makePoint(1, 2);

    try expect(Point(T).pointEqual(p1, p2) == true);
}

test "plusPoint" {
    const T: type = i32;
    const p1 = Point(T).makePoint(1, 2);
    const p2 = Point(T).makePoint(1, 2);
    const p3 = Point(T).plusPoint(p1, p2);

    try expect(p3.X == 2);
    try expect(p3.Y == 4);
}

test "isOrigin" {
    const T: type = i32;
    const p = Point(T).init();

    try expect(Point(T).isOrigin(p) == true);
}

test "quadrant" {
    const T: type = i32;
    const p = Point(T).init();
    const p1 = Point(T).makePoint(1, 1);
    const p2 = Point(T).makePoint(-1, 1);
    const p3 = Point(T).makePoint(-1, -1);
    const p4 = Point(T).makePoint(1, -1);

    try expect(p.quadrant() == undefined);
    try expect(p1.quadrant() == 1);
    try expect(p2.quadrant() == 2);
    try expect(p3.quadrant() == 3);
    try expect(p4.quadrant() == 4);
}

test "midPoint" {
    const T: type = i32;
    const p1 = Point(T).makePoint(1, 1);
    const p2 = Point(T).makePoint(3, 3);
    const target = Point(T).makePoint(2, 2);

    try expect(Point(T).pointEqual(Point(T).midPoint(p1, p2), target));
}

test "distanceFromZero" {
    const T: type = i32;
    const p = Point(T).init();
    const p1 = Point(T).makePoint(1, 2);

    try expect(p.distanceFromZero() == 0);
    try expect(p1.distanceFromZero() == 2.2360679775);
}

test "distanceTwoPoint" {
    const T: type = i32;
    const p = Point(T).init();
    const p1 = Point(T).makePoint(1, 2);

    try expect(Point(T).distanceTwoPoint(p, p1) == 2.2360679775);
}
