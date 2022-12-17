::RhythmRain <- { 
    chart = null,
    game_logic = null,
    modifiers = null

    function start_rainchart(chart_name) {
        IncludeScript("rl_scripts/rhythm_rain/rain_charts/" + chart_name)
        modifiers = ::RhythmRain.Modifiers(1.0, 1.0, 3);
        game_logic = ::RhythmRain.GameLogic(chart, modifiers);
        game_logic.start_rainchart();
    }
};

IncludeScript("rl_scripts/rhythm_rain/game_logic", ::RhythmRain);
IncludeScript("rl_scripts/rhythm_rain/rainchart", ::RhythmRain);
IncludeScript("rl_scripts/rhythm_rain/object", ::RhythmRain);
IncludeScript("rl_scripts/rhythm_rain/modifiers", ::RhythmRain);