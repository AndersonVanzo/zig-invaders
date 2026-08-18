const rl = @import("raylib");
const GameConfig = @import("zig_invaders").GameConfig;
const Player = @import("zig_invaders").Player;
const Shield = @import("zig_invaders").Shield;
const PlayerBullet = @import("zig_invaders").PlayerBullet;
const Invader = @import("zig_invaders").Invader;
const InvaderBullet = @import("zig_invaders").InvaderBullet;

const GameState = enum {
    over,
    won,
    playing,
    menu,
};

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
        .invader_shoot_delay = 60,
        .invader_move_delay = 30,
        .invader_drop_distance = 20,
        .invader_rows = 1,
        .invader_columns = 2,

        // invader bullet
        .invader_bullet_height = 10,
        .invader_bullet_width = 4,
        .invader_bullet_speed = 5,
        .max_invader_bullets = 20,

        // shield
        .shield_height = 60,
        .shield_width = 80,
        .shield_start_x = 150,
        .shield_start_y = 450,
        .shield_spacing_x = 150,
        .max_shields = 4,
    };

    var game_state: GameState = GameState.playing;

    var invader_move_timer: i32 = 0;
    var invader_direction: i8 = 1;
    var invader_shoot_timer: i32 = 0;

    var score: i32 = 0;

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

        if (game_state != GameState.playing) {
            if (game_state == GameState.over) {
                rl.drawText("GAME OVER", 270, 250, 40, rl.Color.red);
            } else if (game_state == GameState.won) {
                rl.drawText("YOU WON!", 270, 250, 40, rl.Color.yellow);
            }

            const score_text = rl.textFormat("Final Score %d", .{score});
            rl.drawText(score_text, 285, 310, 30, rl.Color.white);
            rl.drawText("Press ENTER to play again or ESC to quit", 180, 360, 20, rl.Color.green);

            if (rl.isKeyPressed(rl.KeyboardKey.enter)) {
                // resetGame(&player, &bullets, &invader_bullets, &shields, &invaders, &invader_direction, &score, config);
                game_state = GameState.playing;
            }
            continue;
        }

        // update logic --------------------------------------------

        player.update();

        // player shoots a new bullet
        if (rl.isKeyPressed(rl.KeyboardKey.space)) {
            for (&player_bullets) |*bullet| {
                if (!bullet.active) {
                    bullet.pos_x = player.pos_x + @divTrunc(player.width, 2) - @divTrunc(bullet.width, 2);
                    bullet.pos_y = player.pos_y;
                    bullet.active = true;
                    break;
                }
            }
        }

        // update player bullets
        for (&player_bullets) |*bullet| {
            bullet.update();
            if (!bullet.active) {
                continue;
            }
            // check for invaders collision
            outer_loop: for (&invaders) |*row| {
                for (row) |*invader| {
                    if (invader.alive and bullet.getRect().intersects(invader.getRect())) {
                        bullet.active = false;
                        invader.alive = false;
                        score += 10;
                        break :outer_loop;
                    }
                }
            }
            // check for shields collision
            for (&shields) |*shield| {
                if (shield.health > 0 and bullet.getRect().intersects(shield.getRect())) {
                    bullet.active = false;
                    shield.health -= 1;
                    break;
                }
            }
        }

        // update invaders
        invader_move_timer += 1;
        if (invader_move_timer >= config.invader_move_delay) {
            invader_move_timer = 0;
            var hit_edge = false;
            outer_loop: for (&invaders) |*row| {
                for (row) |*invader| {
                    if (!invader.alive) {
                        continue;
                    }
                    const next_x = invader.pos_x + (config.invader_speed * invader_direction);
                    if (next_x < 0 or next_x + config.invader_width > config.screen_width) {
                        invader_direction *= -1;
                        hit_edge = true;
                        break :outer_loop;
                    }
                }
            }
            outer_loop: for (&invaders) |*row| {
                for (row) |*invader| {
                    if (hit_edge) {
                        invader.update(0, config.invader_drop_distance);
                    } else {
                        invader.update(config.invader_speed * invader_direction, 0);
                    }
                    if (invader.alive and invader.getRect().intersects(player.getRect())) {
                        game_state = GameState.over;
                        break :outer_loop;
                    }
                }
            }
        }

        var all_invaders_dead = true;
        outer_loop: for (&invaders) |*row| {
            for (row) |*invader| {
                if (invader.alive) {
                    all_invaders_dead = false;
                    break :outer_loop;
                }
            }
        }
        if (all_invaders_dead) {
            game_state = GameState.won;
        }

        // invader shoots a new bullet
        invader_shoot_timer += 1;
        if (invader_shoot_timer >= config.invader_shoot_delay) {
            invader_shoot_timer = 0;
            for (&invaders) |*row| {
                for (row) |*invader| {
                    if (invader.alive and rl.getRandomValue(0, 100) < config.invader_shoot_change) {
                        for (&invader_bullets) |*bullet| {
                            if (!bullet.active) {
                                bullet.pos_x = invader.pos_x + @divTrunc(invader.width, 2) - @divTrunc(bullet.width, 2);
                                bullet.pos_y = invader.pos_y + invader.height;
                                bullet.active = true;
                                break;
                            }
                        }
                        break;
                    }
                }
            }
        }

        // update invader bullets
        for (&invader_bullets) |*bullet| {
            bullet.update(config.screen_height);
            if (bullet.active) {
                if (bullet.getRect().intersects(player.getRect())) {
                    bullet.active = false;
                    game_state = GameState.over;
                    break;
                }
                for (&shields) |*shield| {
                    if (shield.health > 0 and bullet.getRect().intersects(shield.getRect())) {
                        bullet.active = false;
                        shield.health -= 1;
                        break;
                    }
                }
            }
        }

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
