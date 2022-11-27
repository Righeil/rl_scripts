class GameLogic {
    rain_chart = null;

    timer_ent = null;
    audio_ent = null;
    start_time = 0;
    current_index = 0;

    playfield_spawn_center = Vector(-2046, 6142, 1464);

    piss_maker_ent = null;
    droplet_maker_ent = null;
    blade_maker_ent = null;

    constructor(rain_chart) {
        this.rain_chart = rain_chart;
        
        timer_ent = Entities.FindByName(null, "RAIN::TIMER");
        audio_ent = SpawnEntityFromTable("ambient_generic", 
        {
            targetname = "audio",
            Message = this.rain_chart.audio_name,
            Health = 10, // Volume
            spawnflags = 33 // Play everywhere AND is not looped
        });
        Entities.FindByClassname(null, "player").PrecacheScriptSound(this.rain_chart.audio_name);

        piss_maker_ent = Entities.FindByName(null, "PISS::MAKER");
        droplet_maker_ent = Entities.FindByName(null, "DROPLET::MAKER");
        blade_maker_ent = Entities.FindByName(null, "BLADE::MAKER");
    }

    function start_rainchart() {
        start_time = Time();
        EntFire(timer_ent.GetName(), "Enable", null, 0.0, null);
        EntFire(
            audio_ent.GetName(), 
            "Pitch", 
            100 * 1.0,
            0.0,
            null
        );
    }

    function stop_rainchart() {
        EntFire(timer_ent.GetName(), "Disable", null, 0.0, null);
        EntFire(
            audio_ent.GetName(), 
            "Volume", 
            "0", 
            0, 
            null
        );
    }

    function update() {
        local current_time = Time() - start_time;

        for (; current_index != rain_chart.objects.len(); current_index += 1) {
            local object = rain_chart.objects[current_index];

            if (object.time < current_time) {
                switch (object.type) {
                    case RainType.Piece:
                        piss_maker_ent.SpawnEntityAtLocation(playfield_spawn_center + Vector(object.x, object.y, 0), Vector(0, object.rotation, 0));
                        break;
                    case RainType.Droplet:
                        droplet_maker_ent.SpawnEntityAtLocation(playfield_spawn_center + Vector(object.x, object.y, 0), Vector(0, object.rotation, 0));
                        break;
                    case RainType.Blade:
                        blade_maker_ent.SpawnEntityAtLocation(playfield_spawn_center + Vector(object.x, object.y, 0), Vector(0, object.rotation, 0));
                        break;
                }
            }
            else { break; }
        }
    }
}