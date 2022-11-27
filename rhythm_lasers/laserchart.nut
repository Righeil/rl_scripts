class LaserChart {
    artist = "";
    title = "";
    audio_name = "";
    duration = 0;
    lasers = [];

    constructor(artist, title, audio_name, lasers) {
        this.artist = artist;
        this.title = title;
        this.audio_name = audio_name;
        this.lasers = lasers;
        this.duration = (this.lasers[this.lasers.len() - 1].time);
    }
}