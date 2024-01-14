const std = @import("std");
const Point = @import("./point.zig").Point;

pub fn main() !void {
    const T = i32;
    var p1 = Point(T).makePoint(1, 2);
    var p2 = Point(T).makePoint(2, 1);

    p1.printPoint();
    p2.printPoint();

    var p3 = Point(T).plusPoint(p1, p2);
    p3.printPoint();
}
