class RainChart {
    artist = null;
    title = null;
    audio_name = null;
    duration = 0;
    objects = [];

    constructor(artist, title, audio_name, objects) {
        this.artist = artist;
        this.title = title;
        this.audio_name = audio_name;
        this.objects = objects; 
        this.duration = (this.objects[this.objects.len() - 1].time);
    }
}

class RainChartMetadata {
    artist = null;
    title = null;
    duration = null;
    difficulty = 0;
    chart_name = null

    constructor(artist, title, duration, difficulty, chart_name) {
        this.artist = artist;
        this.title = title;
        this.duration = duration;
        this.difficulty = difficulty;
        this.chart_name = chart_name;
    }
}