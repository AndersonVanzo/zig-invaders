const rl = @import("raylib");
const GameConfig = @import("zig_invaders").GameConfig;

pub fn main() void {
    const config = GameConfig{
        // window
        .screen_height = 600,
        .screen_width = 800,

        // player
        .player_height = 30,
        .player_width = 50,
        .player_speed = 5,
        .player_start_x = 265,
        .player_start_y = 540,

        // player bullet
        .player_bullet_height = 10,
        .player_bullet_width = 4,
        .player_bullet_speed = 10,
        .max_player_bullets = 10,

        // invader
        .invader_height = 30,
        .invader_width = 40,
        .invader_speed = 5,
        .invader_start_x = 100,
        .invader_start_y = 50,
        .invader_spacing_x = 60,
        .invader_spacing_y = 40,
        .invader_shoot_change = 5,
        .invader_move_delay = 30,
        .invader_drop_distance = 20,
        .invader_rows = 5,
        .invader_columns = 11,

        // invader bullet
        .invader_bullet_height = 10,
        .invader_bullet_width = 4,
        .invader_bullet_speed = 10,
        .max_invader_bullets = 20,

        // shield
        .shield_height = 60,
        .shield_width = 80,
        .shield_start_x = 150,
        .shield_start_y = 450,
        .shield_spacing_x = 150,
    };

    rl.initWindow(config.screen_width, config.screen_height, "Zig Invaders");
    defer rl.closeWindow();

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);
    }
}
