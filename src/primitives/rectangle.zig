pub const Rectangle = struct {
    x: i32,
    y: i32,
    height: i32,
    width: i32,

    pub fn left(self: @This()) i32 {
        return self.x;
    }

    pub fn right(self: @This()) i32 {
        return self.x + self.width;
    }

    pub fn top(self: @This()) i32 {
        return self.y;
    }

    pub fn bottom(self: @This()) i32 {
        return self.y + self.height;
    }

    pub fn intersects(self: @This(), other: Rectangle) bool {
        return self.left() < other.right() and
            self.right() > other.left() and
            self.top() < other.bottom() and
            self.bottom() > other.top();
    }
};
