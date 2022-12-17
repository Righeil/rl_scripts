::Main <- {}

local servercommand = Entities.FindByClassname(null, "point_servercommand")
EntFireByHandle(servercommand, "Command", "mp_enableroundwaittime 0", 0, null, null);
EntFireByHandle(servercommand, "Command", "mp_waitingforplayers_cancel 1", 0, null, null);

IncludeScript("rl_scripts/audio", ::Main);
IncludeScript("rl_scripts/text", ::Main);
IncludeScript("rl_scripts/event", ::Main);
IncludeScript("rl_scripts/score", ::Main);

IncludeScript("rl_scripts/rhythm_lasers");
IncludeScript("rl_scripts/rhythm_rain");
IncludeScript("rl_scripts/rhythm_rain_song_select")