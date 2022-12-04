class Audio {
    audio_name = null;
    entity = null;

    constructor(audio_name) {
        entity = SpawnEntityFromTable("ambient_generic", 
        {
            targetname = "audio",
            Message = audio_name,
            Health = 10, // Volume
            spawnflags = 33 // Play everywhere AND is not looped
        });
        Entities.FindByClassname(null, "player").PrecacheScriptSound(audio_name);
    }

    function play(time_rate) {
        EntFire(
            entity.GetName(), 
            "Pitch", 
            100 * time_rate,
            0.0,
            null
        );
    }

    function stop() {
        EntFire(
            entity.GetName(), 
            "Volume", 
            "0", 
            0, 
            null
        );
    }
}