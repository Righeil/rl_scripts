::RhythmRain <- { 
    chart = null,
    game_logic = null

    function start_rainchart() {
        IncludeScript("rl_scripts/rhythm_rain/rain_charts/sendan_life")
        game_logic = ::RhythmRain.GameLogic(chart);
        game_logic.start_rainchart();
    }
};

IncludeScript("rl_scripts/rhythm_rain/game_logic", ::RhythmRain);
IncludeScript("rl_scripts/rhythm_rain/rainchart", ::RhythmRain);
IncludeScript("rl_scripts/rhythm_rain/object", ::RhythmRain);