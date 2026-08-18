const rl = @import("raylib");
const Rectangle = @import("../primitives/rectangle.zig").Rectangle;

pub const Player = struct {
    pos_x: i32,
    pos_y: i32,

    height: i32,
    width: i32,

    speed: i32,

    pub fn init(pos_x: i32, pos_y: i32, height: i32, width: i32, speed: i32) @This() {
        return .{
            .pos_x = pos_x,
            .pos_y = pos_y,
            .height = height,
            .width = width,
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

    pub fn update(self: *@This()) void {
        if (rl.isKeyDown(rl.KeyboardKey.right) or rl.isKeyDown(rl.KeyboardKey.d)) {
            self.pos_x += self.speed;
        }
        if (rl.isKeyDown(rl.KeyboardKey.left) or rl.isKeyDown(rl.KeyboardKey.a)) {
            self.pos_x -= self.speed;
        }
        // clamp player in the left boundary
        if (self.pos_x < 0) {
            self.pos_x = 0;
        }
        // clamp player in the right boundary
        if (self.pos_x + self.width > rl.getScreenWidth()) {
            self.pos_x = rl.getScreenWidth() - self.width;
        }
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
