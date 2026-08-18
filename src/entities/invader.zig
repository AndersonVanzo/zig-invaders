const rl = @import("raylib");
const Rectangle = @import("../primitives/rectangle.zig").Rectangle;

pub const Invader = struct {
    pos_x: i32,
    pos_y: i32,

    height: i32,
    width: i32,

    alive: bool,
    speed: i32,

    pub fn init(pos_x: i32, pos_y: i32, height: i32, width: i32, speed: i32) @This() {
        return .{
            .pos_x = pos_x,
            .pos_y = pos_y,
            .height = height,
            .width = width,
            .alive = true,
            .speed = speed,
        };
    }

    pub fn draw(self: @This()) void {
        rl.drawRectangle(
            self.pos_x,
            self.pos_y,
            self.width,
            self.height,
            rl.Color.blue,
        );
    }

    pub fn update(self: *@This(), delta_x: i32, delta_y: i32) void {
        self.pos_x += delta_x;
        self.pos_y += delta_y;
    }

    pub fn getRect(self: @This()) Rectangle {
        return .{
            .x = self.pos_x,
            .y = self.pos_y,
            .height = self.height,
            .width = self.width,
        };
    }
};
