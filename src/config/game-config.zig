pub const GameConfig = struct {
    // window
    screen_height: i32,
    screen_width: i32,

    // player
    player_height: i32,
    player_width: i32,
    player_speed: u8,
    player_start_x: i32,
    player_start_y: i32,

    // player bullet
    player_bullet_height: i32,
    player_bullet_width: i32,
    player_bullet_speed: u8,
    max_player_bullets: u8,

    // invader
    invader_height: i32,
    invader_width: i32,
    invader_speed: i8,
    invader_start_x: i32,
    invader_start_y: i32,
    invader_spacing_x: i32,
    invader_spacing_y: i32,
    invader_shoot_change: u8,
    invader_shoot_delay: u8,
    invader_move_delay: u8,
    invader_drop_distance: u8,
    invader_rows: u8,
    invader_columns: u8,

    // invader bullet
    invader_bullet_height: i32,
    invader_bullet_width: i32,
    invader_bullet_speed: u8,
    max_invader_bullets: u8,

    // shield
    shield_height: i32,
    shield_width: i32,
    shield_start_x: i32,
    shield_start_y: i32,
    shield_spacing_x: i32,
    max_shields: u8,
};
