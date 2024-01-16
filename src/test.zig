const std = @import("std");
const expect = std.testing.expect;
const Point = @import("zig-point").Point;

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

test "move" {
    const T: type = i32;
    var p = Point(T).init();

    p.move(10, 5);

    try expect(Point(T).pointEqual(p, Point(T).makePoint(10, 5)));
}
