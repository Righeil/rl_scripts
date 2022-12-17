class Grade {
    name = "";
    description = "";
    sound_name = "";

    constructor(name, description, sound_name) {
        this.name = name;
        this.description = description;
        this.sound_name = sound_name;
    }
}

class LaserScore {
    isPlayerDied = false;
    hit_count = 0;

    function get_grade() {
        if (hit_count == 0) { return ::Main.Grade("S", "Perfect!!!",                       "vo/heavy_positivevocalization04.mp3") }
        if (hit_count < 5)  { return ::Main.Grade("A",  "Great!",                           "vo/engineer_cheers03.mp3") }
        if (hit_count < 13) { return ::Main.Grade("B", "Not bad...",                       "vo/sniper_positivevocalization05.mp3") }
        if (hit_count < 25) { return ::Main.Grade("C", "At least you survived...",         "vo/soldier_jeers06.mp3") }
        if (hit_count > 24) { return ::Main.Grade("D", "Dude, you are really bad at this.", "vo/scout_domination19.mp3") }
    }
}

class RainScore {
    is_player_died = false;
    hit_count = 0;

    function get_grade() {
        if (is_player_died) { return ::Main.Grade("L", "RIP BOZO",                         "vo/scout_LaughLong02.mp3") }
        if (hit_count == 0) { return ::Main.Grade("S", "Perfect!!!",                       "vo/heavy_positivevocalization04.mp3") }
        if (hit_count == 1) { return ::Main.Grade("A",  "Great!",                           "vo/engineer_cheers03.mp3") }
        if (hit_count <= 3) { return ::Main.Grade("B", "Not bad...",                       "vo/sniper_positivevocalization05.mp3") }
        if (hit_count <= 6) { return ::Main.Grade("C", "At least you survived...",         "vo/soldier_jeers06.mp3") }
        if (hit_count > 6)  { return ::Main.Grade("D", "Dude, you are really bad at this.", "vo/scout_domination19.mp3") }
    }
}