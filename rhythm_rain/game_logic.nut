class GameLogic {
    rain_chart = null;
    modifiers = null;
    score = null;

    timer_ent = null;
    music = null;
    start_time = 0;
    current_index = 0;

    playfield_spawn_center = Vector(-2046, 6142, 1540);

    piss_maker_ent = null;
    droplet_maker_ent = null;
    blade_maker_ent = null;

    title_text = null;
    stats_text = null;
    result_text = null;

    result_audio_ent = null;

    death_event_listener = null;

    constructor(rain_chart, modifiers) {
        this.rain_chart = rain_chart;
        this.modifiers = modifiers;
        score = ::Main.RainScore();
        
        timer_ent = Entities.FindByName(null, "RAIN::TIMER");
        music = ::Main.Audio(this.rain_chart.audio_name); 

        piss_maker_ent = Entities.FindByName(null, "PISS::MAKER");
        droplet_maker_ent = Entities.FindByName(null, "DROPLET::MAKER");
        blade_maker_ent = Entities.FindByName(null, "BLADE::MAKER");

        title_text = ::Main.TitleText(format("%s - %s", this.rain_chart.artist, this.rain_chart.title));
        stats_text = ::Main.RainStatsText();
        result_text = ::Main.ResultText();

        death_event_listener = ::Main.Event("player_death", this, "player_died");
    }

    function clean() {
        music.entity.Kill();
        result_audio_ent.entity.Kill();

        title_text.entity.Kill();
        stats_text.entity.Kill();
        result_text.entity.Kill();

        death_event_listener.entity.Kill();
    }

    function start_rainchart() {
        title_text.display();
        stats_text.update(modifiers, score);
        stats_text.display();

        start_time = Time() + 0.75;
        EntFire(timer_ent.GetName(), "Enable", null, 0.0, null);
        music.play(modifiers.game_speed * modifiers.music_speed, 0.75);

        // After rainchart.duration seconds we call the stop_rainchart() function
        EntFire(
            "main", 
            "RunScriptCode", 
            "::RhythmRain.game_logic.stop_rainchart()", 
            (rain_chart.duration / modifiers.music_speed) + 1.2 + 0.75, 
            null
        );
    }

    function stop_rainchart() {
        EntFire(timer_ent.GetName(), "Disable", null, 0.0, null);
        music.stop();

        local grade = score.get_grade();
        result_text.update(grade);
        result_text.display();

        result_audio_ent = ::Main.Audio(grade.sound_name);
        result_audio_ent.play(1.0, 0);

        EntFire("main", "RunScriptCode", "::RhythmRain.game_logic.exit()", 2.0, null);
    }

    function exit() {
        local player = Entities.FindByClassname(null, "player");
        local spawn = Entities.FindByClassname(null, "info_player_teamspawn");

        if (score.is_player_died) {
            player.ForceRespawn()
        } 
        else {
            player.SetOrigin(spawn.GetOrigin());
            player.SnapEyeAngles(spawn.EyeAngles());
            player.SetHealth(player.GetMaxHealth());
        }

        clean()
    }

    function update() {
        local current_time = (Time() - start_time) * modifiers.music_speed;

        for (; current_index != rain_chart.objects.len(); current_index += 1) {
            local object = rain_chart.objects[current_index];

            if (object.time > current_time) {
                break;
            }

            local position = playfield_spawn_center + Vector(object.x, object.y, 0);
            local rotation = Vector(0, object.rotation, 0);

            switch (object.type) {
                case RainType.Piece:
                    piss_maker_ent.SpawnEntityAtLocation(position, rotation);
                    break;
                case RainType.Droplet:
                    droplet_maker_ent.SpawnEntityAtLocation(position, rotation);
                    break;
                case RainType.Blade:
                    blade_maker_ent.SpawnEntityAtLocation(position, rotation);
                    break;
            }
        }
    }

    function hit() {
        score.hit_count += 1;
        stats_text.update(modifiers, score);
        stats_text.display();
    }

    function player_died(event_data) {
        if (event_data.death_flags == 32) { // 32 == cheated death
            Entities.FindByClassname(null, "player").BleedPlayer(69);
        }

        score.is_player_died = true;
        stop_rainchart();
    }
}