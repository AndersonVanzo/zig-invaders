pub const GameConfig = struct {
    // window
    screen_height: i32,
    screen_width: i32,

    // player
    player_height: i32,
    player_width: i32,
    player_speed: i32,
    player_start_x: i32,
    player_start_y: i32,

    // player bullet
    player_bullet_height: i32,
    player_bullet_width: i32,
    player_bullet_speed: i32,

    // invader
    invader_height: i32,
    invader_width: i32,
    invader_speed: i32,
    invader_start_x: i32,
    invader_start_y: i32,
    invader_spacing_x: i32,
    invader_spacing_y: i32,

    // invader bullet
    invader_bullet_height: i32,
    invader_bullet_width: i32,
    invader_bullet_speed: i32,

    // shield
    shield_height: i32,
    shield_width: i32,
    shield_start_x: i32,
    shield_start_y: i32,
    shield_spacing_x: i32,
};
