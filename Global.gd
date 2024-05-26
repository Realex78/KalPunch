extends Node

var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
var music_file = "res://Assets/Music/TitleScreen.mp3"

func _ready():
	if not has_node("MusicPlayer"):
		add_child(music_player)
		music_player.name = "MusicPlayer"
		
		var file = FileAccess.open(music_file, FileAccess.READ)
		if file:
			var music = load(music_file)
			if music is AudioStream:
				music_player.stream = music
				if not music_player.playing:
					music_player.play()
	elif not music_player.playing:
		music_player.play()

func play_music():
	if not music_player.playing:
		music_player.play()

func stop_music():
	if music_player.playing:
		music_player.stop()

var player_1_name="Jugador 1";
var player_1_score=10;

var player_2_name="Jugador 2";
var player_2_score=8;

var player_3_name="Jugador 3";
var player_3_score=6;

var player_4_name="Jugador 4";
var player_4_score=4;

var First;
var Second;
var Third;
var Fourth;

var Pivot;
