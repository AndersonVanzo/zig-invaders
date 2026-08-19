# Zig Invaders

A small Space Invaders clone written in [Zig](https://ziglang.org/) using [raylib](https://www.raylib.com/) via [raylib-zig](https://github.com/raylib-zig/raylib-zig).

## Requirements

- Zig `0.16.0` or newer

Dependencies are fetched automatically by the Zig package manager on first build.

## Running

```bash
zig build run
```

To just build the executable (output lands in `zig-out/bin/`):

```bash
zig build
```

Run the tests:

```bash
zig build test
```

## Controls

| Key | Action |
| --- | --- |
| `←` / `A` | Move left |
| `→` / `D` | Move right |
| `Space` | Shoot |
| `Enter` | Start / restart the game |
| `Esc` | Quit |

## Gameplay

Invaders march sideways, drop down a row when they reach a screen edge, and shoot back at random. Each invader you destroy is worth 10 points. Four shields sit above the player and absorb 10 hits each — from invader bullets *and* your own — fading out as they take damage.

You lose if an invader bullet hits you or the invaders reach your ship. You win by clearing the whole formation.

## Project layout

```
src/
├── main.zig                       # window setup, game loop, state machine
├── root.zig                       # library root, re-exports the types below
├── config/game-config.zig         # GameConfig: all tunable values
├── primitives/rectangle.zig       # Rectangle + AABB intersection test
├── entities/
│   ├── player.zig
│   ├── invader.zig
│   └── shield.zig
└── projectiles/
    ├── player_bullet.zig
    └── invader_bullet.zig
```

## Tweaking the game

Everything tunable — screen size, speeds, spacing, fire rates, grid dimensions — lives in the `GameConfig` literal at the top of `main()` in [src/main.zig](src/main.zig). The invader grid defaults to a small `1 × 2` formation; raise `invader_rows` and `invader_columns` for a real fight.
