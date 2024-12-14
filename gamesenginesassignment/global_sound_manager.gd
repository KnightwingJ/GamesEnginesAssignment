extends Node

var sound_sequence=[] # Store the sequence gloablly
var performance_scene:PackedScene = preload("res://Performance.tscn")

var current_player: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
var current_audio_player = null
var current_index = 0

var global_volume=0
var global_pitch=1.0

func play_next_sound():
	if current_index < sound_sequence.size():
		var audio_stream = sound_sequence[current_index]
		var sound_player = AudioStreamPlayer.new()
		sound_player.stream = audio_stream
		sound_player.volume_db=global_volume
		sound_player.pitch_scale=global_pitch
		add_child(sound_player)
		
		 # Set it as the current player
		current_audio_player = sound_player
		
		sound_player.play()
		print("Playing sound:", audio_stream)

		# Connect finished signal
		sound_player.connect("finished", Callable(self, "_on_sound_finished"))
	else:
		print("Finished playing the sequence.")
		current_index = 0  # Reset
		play_next_sound()

func _on_sound_finished():
	if current_audio_player:
		current_audio_player.queue_free()  # Cleanup the finished player
	current_index += 1
	play_next_sound()
func switch_to_playback_scene():
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	var new_scene=performance_scene.instantiate()
	get_tree().root.add_child(new_scene)

func set_global_volume(value):
	global_volume=value
	if current_audio_player:
		current_audio_player.volume_db = global_volume

func set_global_pitch(value):
	global_pitch=value
	if current_audio_player:
		current_audio_player.pitch_scale = global_pitch

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
