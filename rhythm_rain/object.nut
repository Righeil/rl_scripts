enum RainType {
    Piece,
    Droplet,
    Blade
}

class Object {
    x = 0.0;
    y = 0.0;
    rotation = 0.0;
    time = 0.0;
    type = null

    constructor(x, y, rotation, time, type) {
        this.x = x;
        this.y = y;
        this.rotation = rotation;
        this.time = time;
        this.type = type;
    }
}