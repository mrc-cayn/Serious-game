extends Node
@onready var music: AudioStreamPlayer2D = $music

func play_music(music_path : String):
	var new_music := load(music_path)
	music.stream = new_music
	music.play()

func music_fade(audio_player: AudioStreamPlayer,
	 final_volume_db: float = 0.0,
	 fade_time: float = 1.0):
	audio_player.volume_db = -80.0
	var tween = create_tween()
	tween.tween_property(audio_player,
	 "volume_db", final_volume_db, fade_time)
	tween.set_ease(Tween.EASE_OUT)
	pass
