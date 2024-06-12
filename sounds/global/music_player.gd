extends AudioStreamPlayer

const DANHEIM_BERSERKIR = preload("res://sounds/music/danheim/Danheim_Berserkir.mp3")

func _play_music(music:AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume - 20.0
	play()
		
func play_music_level():
	print("inside play_music_level")
	_play_music(DANHEIM_BERSERKIR)
	
func play_FX(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()
	
	
