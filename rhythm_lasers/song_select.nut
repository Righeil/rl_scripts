class SongSelect {
    selected_laserchart_id = 0;
    laserchart_count = 0;

    constructor(laserchart_count) {
        this.laserchart_count = laserchart_count;
    }

    function scroll(value) {
        selected_laserchart_id += value;

        if (selected_laserchart_id < 0) {
            selected_laserchart_id = 0;
        }
        if (selected_laserchart_id > laserchart_count) {
            selected_laserchart_id = laserchart_count;
        }

        EntFire("song_select_laserchart_screen", "Skin", selected_laserchart_id, 0.0, null);
    }

    function select_laserchart() {
        local playfield_tp_destination_ent = Entities.FindByName(null, "playfield_tp_destination");
        local player_ent = Entities.FindByClassname(null, "player");
        player_ent.SetOrigin(playfield_tp_destination_ent.GetOrigin());
        player_ent.SetAbsAngles(playfield_tp_destination_ent.GetAbsAngles());

        // УДАЛИ НАХУЙ ЭТО
        EntFire("servercommand", "Command", "stopsoundscape", 0.0, null);
        
        ::RhythmLasers.start_laserchart(selected_laserchart_id);
    }
}

::RhythmLasers.song_select <- SongSelect(::RhythmLasers.laserchart_filenames_list.len() - 1);