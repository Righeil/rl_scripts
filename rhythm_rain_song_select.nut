::RhythmRainSongSelect <- {
    chart_list = null,
    selected_chart_id = 0,

    artist_text_ent = Entities.FindByName(null, "RRSongSelectArtist"),
    title_text_ent = Entities.FindByName(null, "RRSongSelectTitle"),
    duration_text_ent = Entities.FindByName(null, "RRSongSelectDuration"),

    function scroll(direction) {
        selected_chart_id += direction;

        if (selected_chart_id == -1) {
            selected_chart_id = chart_list.len() - 1;
        } 
        else if (selected_chart_id == chart_list.len()) {
            selected_chart_id = 0;
        }
        
        EntFireByHandle(artist_text_ent, "SetText", chart_list[selected_chart_id].artist, 0, null, null)
        EntFireByHandle(title_text_ent, "SetText", chart_list[selected_chart_id].title, 0, null, null)
        EntFireByHandle(duration_text_ent, "SetText", chart_list[selected_chart_id].duration, 0, null, null)
    }

    function start() {
        local rhythm_rain_tp = Entities.FindByName(null, "RhythmRainTP");
        local player_ent = Entities.FindByClassname(null, "player");
        player_ent.SetOrigin(rhythm_rain_tp.GetOrigin());
        player_ent.SnapEyeAngles(QAngle(-89, 0, 0));

        ::RhythmRain.start_rainchart(chart_list[selected_chart_id].chart_name);
    }
}

IncludeScript("rl_scripts/rhythm_rain/raincharts", ::RhythmRainSongSelect);