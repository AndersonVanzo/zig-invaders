const rl = @import("raylib");
const Rectangle = @import("../primitives/rectangle.zig").Rectangle;

pub const PlayerBullet = struct {
    pos_x: i32,
    pos_y: i32,

    height: i32,
    width: i32,

    active: bool,
    speed: i32,

    pub fn init(pos_x: i32, pos_y: i32, height: i32, width: i32, speed: i32) @This() {
        return .{
            .pos_x = pos_x,
            .pos_y = pos_y,
            .height = height,
            .width = width,
            .active = false,
            .speed = speed,
        };
    }

    pub fn draw(self: @This()) void {
        if (!self.active) {
            return;
        }
        rl.drawRectangle(
            self.pos_x,
            self.pos_y,
            self.width,
            self.height,
            rl.Color.red,
        );
    }

    pub fn update(self: *@This()) void {
        if (!self.active) {
            return;
        }
        self.pos_y -= self.speed;
        if (self.pos_y <= 0) {
            self.active = false;
        }
    }

    pub fn getRect(self: @This()) Rectangle {
        return .{
            .x = self.position_x,
            .y = self.position_y,
            .height = self.height,
            .width = self.width,
        };
    }
};
