enum LaserType {
    None,
    Horizontal, // 0 - Lower | 1 - Upper
    Vertical,   // 0 - Left | 9 - Right
    Box,        // 0 - Left | 8 - Right
    Wall        // 0 - Left | 2 - Right
}

class Laser {
    time = 0.0;
    index = 0;
    type = LaserType.None;

    constructor(time, index, type) {
        this.time = time;
        this.index = index;
        this.type = type;
    }
}