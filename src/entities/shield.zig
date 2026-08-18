const rl = @import("raylib");
const Rectangle = @import("zig_invaders").Rectangle;

pub const Shield = struct {
    pos_x: i32,
    pos_y: i32,

    height: i32,
    width: i32,

    health: u8,

    pub fn init(pos_x: i32, pos_y: i32, height: i32, width: i32) @This() {
        return .{
            .pos_x = pos_x,
            .pos_y = pos_y,
            .height = height,
            .width = width,
            .health = 10,
        };
    }

    pub fn draw(self: @This()) void {
        if (self.health <= 0) {
            return;
        }
        const alpha = @as(u8, @intCast(@min(255, self.health * 25)));
        rl.drawRectangle(
            self.pos_x,
            self.pos_y,
            self.width,
            self.height,
            rl.Color.init(0, 255, 255, alpha),
        );
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
