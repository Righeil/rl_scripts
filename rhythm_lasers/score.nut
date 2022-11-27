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

class Score {
    isPlayerDied = false;
    hit_count = 0;

    function get_grade() {
        if (hit_count == 0) { return ::RhythmLasers.Grade("S", "Perfect!!!",                       "vo/heavy_positivevocalization04.mp3") }
        if (hit_count < 5) { return ::RhythmLasers.Grade("A",  "Great!",                           "vo/engineer_cheers03.mp3") }
        if (hit_count < 13) { return ::RhythmLasers.Grade("B", "Not bad...",                       "vo/sniper_positivevocalization05.mp3") }
        if (hit_count < 25) { return ::RhythmLasers.Grade("C", "At least you survived...",         "vo/soldier_jeers06.mp3") }
        if (hit_count > 24) { return ::RhythmLasers.Grade("D", "Dude you are really bad at this.", "vo/scout_domination19.mp3") }
    }
}