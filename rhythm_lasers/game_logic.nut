class GameLogic {
    laserchart = null;

    settings = null;
    modifiers = null;

    score = null;

    audio_ent = null;
    result_audio_ent = null;

    title_text = null;
    stats_text = null;
    result_text = null;

    death_event_listener = null;

    constructor(laserchart, settings, modifiers) {
        this.laserchart = laserchart;
        this.settings = settings;
        this.modifiers = modifiers;

        audio_ent = SpawnEntityFromTable("ambient_generic", 
        {
            targetname = "audio",
            Message = this.laserchart.audio_name,
            Health = 10, // Volume
            spawnflags = 33 // Play everywhere AND is not looped
        });
        Entities.FindByClassname(null, "player").PrecacheScriptSound(this.laserchart.audio_name);

        title_text = ::RhythmLasers.TitleText(format("%s - %s", this.laserchart.artist, this.laserchart.title));
        stats_text = ::RhythmLasers.StatsText();
        result_text = ::RhythmLasers.ResultText();

        result_audio_ent = SpawnEntityFromTable("ambient_generic", 
        {
            targetname = "result_audio",
            Message = this.laserchart.audio_name,
            Health = 10, // Volume
            spawnflags = 33 // Play everywhere AND is not looped
        });

        death_event_listener = ::RhythmLasers.Event("player_death", this, "player_died");
    }

    function start_laserchart() {
        score = ::RhythmLasers.Score()

        title_text.display();
        stats_text.update(modifiers, score);
        stats_text.display();

        // This foreach will blow up your computer
        // Stupid solution, but it works
        // AND ADDS DELAYS
        // So next time we need to make the spawn of lasers through think()
        foreach (laser in laserchart.lasers) {
            local laser_str = null;

            switch (laser.type) {
                case LaserType.Horizontal:
                    laser_str = "LASER::HORIZONTAL" + laser.index;
                    break;
                case LaserType.Vertical:
                    laser_str = "LASER::VERTICAL" + laser.index;
                    break;
                case LaserType.Box:
                    laser_str = "LASER::BOX" + laser.index;
                    break;
                case LaserType.Wall:
                    laser_str = "LASER::WALL" + laser.index;
                    break;
                default:
                    printl("/!\\ Unknown type of laser.");
                    return;
            }
            EntFire(laser_str, "ForceSpawn", null, settings.prepare_time + laser.time , null);
        }

        // Starting the music
        EntFire(
            audio_ent.GetName(), 
            "Pitch", 
            100 * modifiers.time_rate, 
            settings.prepare_time + settings.audio_offset, 
            null
        );

        // Setting the game speed
        EntFire(
            "servercommand", 
            "Command", 
            format("host_timescale %f", modifiers.time_rate), 
            0, 
            null
        );

        // After laserchart.duration seconds we call the laserchart_is_over() function
        EntFire(
            "main", 
            "RunScriptCode", 
            "::RhythmLasers.game_logic.end_laserchart()", 
            settings.prepare_time + laserchart.duration + 1.2, 
            null
        );
    }

    function hit() {
        score.hit_count += 1;
        stats_text.update(modifiers, score);
        stats_text.display();
    }

    function player_died(event_data) {
        if (event_data.death_flags == 32) { // 32 == cheated death
            return;
        }

        score.isPlayerDied = true;
        end_laserchart()
    }

    function end_laserchart() {
        //Turning off the music
        EntFire(audio_ent.GetName(), "Volume", "0", 0.0, null);

        if (score.isPlayerDied) {
            ::RhythmLasers.return_to_lobby(0.0)
            return
        }

        local grade = score.get_grade();
        result_text.update(grade);
        result_text.display();

        Entities.FindByClassname(null, "player").PrecacheScriptSound(grade.sound_name);
        result_audio_ent.__KeyValueFromString("message", grade.sound_name);
        EntFire(result_audio_ent.GetName(), "PlaySound", null, 0.0, null);

        // Setting the game speed back to normal
        EntFire(
            "servercommand", 
            "Command", 
            (format("host_timescale %f", 1.0)), 
            0, 
            null
        );

        ::RhythmLasers.return_to_lobby(6.0)
    }
}