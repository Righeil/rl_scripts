class Text {
    entity = null;

    function update();
    function display() {
        EntFire(entity.GetName(), "Display", null, 0.0, null);
    }
}

class TitleText extends Text {
    constructor(text) {
        entity = SpawnEntityFromTable("game_text", {
            targetname = "title",
            Message = text,
            X = "-1",
            Y = "-0.25",
            Channel = 4,
            Color = Vector(204, 204, 204),
            Effect = "0", 
            FadeIn = "0.25",
            FadeOut = "0.5",
            HoldTime = "2",
            spawnflags = 1 // All players
        });
    }
}

class StatsText extends Text {
    constructor() {
        entity = SpawnEntityFromTable("game_text", {
            targetname = "stats",
            X = "-1",
            Y = "0.9",
            Channel = 3,
            Color = Vector(204, 204, 204),
            Effect = "0", 
            FadeIn = "0.25",
            FadeOut = "0.5",
            HoldTime = "999",
            spawnflags = 1 // All players
        });
    }

    function update(modifiers, score) {
        local message = format("Hits: %i | Time rate: %.2fx", score.hit_count, modifiers.time_rate);
        if (modifiers.no_heal) { message += " | No heal"}
        if (modifiers.low_health) { message += " | Low health"}
        entity.__KeyValueFromString("message", message);
    }
}

class RainStatsText extends StatsText {
    function update(modifiers, score) {
        local message = format("Hits: %i | Music speed: %.2fx", score.hit_count, modifiers.music_speed);
        message += format(" | Health: %i", modifiers.health);
        
        entity.__KeyValueFromString("message", message);
    }
}

class ResultText extends Text {
    constructor() {
        entity = SpawnEntityFromTable("game_text", {
            targetname = "result",
            X = "-1",
            Y = "0.6",
            Channel = 4,
            Color = Vector(204, 204, 204),
            Effect = "0", 
            FadeIn = "0.25",
            FadeOut = "0.25",
            HoldTime = "7",
            spawnflags = 1 // All players
        });
    }

    function update(grade) {
        local message = format("Grade: %s | %s", grade.name, grade.description);
        entity.__KeyValueFromString("message", message);
    }
}
