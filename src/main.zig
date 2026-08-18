const rl = @import("raylib");
const GameConfig = @import("zig_invaders").GameConfig;
const Player = @import("zig_invaders").Player;
const Shield = @import("zig_invaders").Shield;
const PlayerBullet = @import("zig_invaders").PlayerBullet;
const Invader = @import("zig_invaders").Invader;
const InvaderBullet = @import("zig_invaders").InvaderBullet;

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
        .max_shields = 4,
    };

    rl.initWindow(config.screen_width, config.screen_height, "Zig Invaders");
    rl.setTargetFPS(60);
    defer rl.closeWindow();

    var player = Player.init(
        config.player_start_x,
        config.player_start_y,
        config.player_height,
        config.player_width,
        config.player_speed,
    );

    var shields: [config.max_shields]Shield = undefined;
    for (&shields, 0..) |*shield, index| {
        const pos_x = config.shield_start_x + @as(i32, @intCast(index)) * config.shield_spacing_x;
        shield.* = Shield.init(
            pos_x,
            config.shield_start_y,
            config.shield_height,
            config.shield_width,
        );
    }

    var player_bullets: [config.max_player_bullets]PlayerBullet = undefined;
    for (&player_bullets) |*bullet| {
        bullet.* = PlayerBullet.init(
            0,
            0,
            config.player_bullet_height,
            config.player_bullet_width,
            config.player_bullet_speed,
        );
    }

    var invaders: [config.invader_rows][config.invader_columns]Invader = undefined;
    for (&invaders, 0..) |*row, rowIndex| {
        for (row, 0..) |*invader, colIndex| {
            const pos_x = config.invader_start_x + @as(i32, @intCast(colIndex)) * config.invader_spacing_x;
            const pos_y = config.invader_start_y + @as(i32, @intCast(rowIndex)) * config.invader_spacing_y;
            invader.* = Invader.init(
                pos_x,
                pos_y,
                config.invader_height,
                config.invader_width,
                config.invader_speed,
            );
        }
    }

    var invader_bullets: [config.max_invader_bullets]InvaderBullet = undefined;
    for (&invader_bullets) |*bullet| {
        bullet.* = InvaderBullet.init(
            0,
            0,
            config.invader_bullet_height,
            config.invader_bullet_width,
            config.invader_bullet_speed,
        );
    }

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);

        // draw logic ----------------------------------------------

        for (&shields) |*shield| {
            shield.draw();
        }

        player.draw();

        for (&player_bullets) |*bullet| {
            bullet.draw();
        }

        for (&invader_bullets) |*invader_bullet| {
            invader_bullet.draw();
        }

        for (&invaders) |*row| {
            for (row) |*invader| {
                invader.draw();
            }
        }
    }
}
