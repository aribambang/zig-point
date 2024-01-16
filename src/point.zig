const std = @import("std");
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

        pub fn move(self: *Self, deltaX: T, deltaY: T) void {
            setX(self, getX(self.*) + deltaX);
            setY(self, getY(self.*) + deltaY);
        }

        fn setX(self: *Self, newX: T) void {
            self.X = newX;
        }

        fn setY(self: *Self, newY: T) void {
            self.Y = newY;
        }

        fn getX(self: Self) T {
            return self.X;
        }

        fn getY(self: Self) T {
            return self.Y;
        }
    };
}
