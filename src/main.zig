const std = @import("std");
const Point = @import("./point.zig").Point;

pub fn main() !void {
    const T = i32;
    var p = Point(T).makePoint(1, 2);

    p.printPoint();
}
