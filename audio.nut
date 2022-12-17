class Audio {
    entity = null;

    constructor(audio_name) {
        entity = SpawnEntityFromTable("ambient_generic", 
        {
            targetname = audio_name,
            Message = audio_name,
            Health = 10, // Volume
            spawnflags = 33 // Play everywhere AND is not looped
        });
        Entities.FindByClassname(null, "player").PrecacheScriptSound(audio_name);
    }

    function play(speed, delay) {
        EntFireByHandle(entity, "Pitch", (100 * speed).tostring(), delay, null, null);
    }

    function stop() {
        EntFireByHandle(entity, "Volume", "0", 0, null, null);
    }
}