::RhythmLasers <- {
    chart = null,
    laserchart_filenames_list = null,
    song_select = null,
    settings = null,
    modifiers = null,
    game_logic = null,

    function init() {
        settings = ::RhythmLasers.Settings(0.0, 2.0)
        modifiers = ::RhythmLasers.Modifiers(1.05, true, false);
    }

    function start_laserchart(laserchart_id) {
        IncludeScript("rl_scripts/rhythm_lasers/lasercharts/" + laserchart_filenames_list[laserchart_id]);
        game_logic = ::RhythmLasers.GameLogic(chart, settings, modifiers);
        game_logic.start_laserchart();
    }

    function return_to_lobby(delay) {
        EntFire("servercommand", "Command", "mp_restartgame 1", delay, null);
    }
};

IncludeScript("rl_scripts/rhythm_lasers/laser", ::RhythmLasers);
IncludeScript("rl_scripts/rhythm_lasers/laserchart", ::RhythmLasers);
IncludeScript("rl_scripts/rhythm_lasers/lasercharts/list", ::RhythmLasers);
IncludeScript("rl_scripts/rhythm_lasers/song_select", ::RhythmLasers);
IncludeScript("rl_scripts/rhythm_lasers/game_logic", ::RhythmLasers);
IncludeScript("rl_scripts/rhythm_lasers/score", ::RhythmLasers);
IncludeScript("rl_scripts/rhythm_lasers/settings", ::RhythmLasers);
IncludeScript("rl_scripts/rhythm_lasers/modifiers", ::RhythmLasers);
IncludeScript("rl_scripts/rhythm_lasers/event", ::RhythmLasers);
IncludeScript("rl_scripts/rhythm_lasers/text", ::RhythmLasers);

::RhythmLasers.init();