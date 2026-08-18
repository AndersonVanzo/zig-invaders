const rl = @import("raylib");

pub fn main() void {
    rl.initWindow(500, 500, "Zig Invaders");
    defer rl.closeWindow();

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);
    }
}
