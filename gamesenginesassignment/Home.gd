extends Control

@export var audio_path:NodePath
var sound_manager
var audio_player:AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	sound_manager=GlobalSoundManager
	pass # Replace with function body.


func _on_home_pressed():
	get_tree().change_scene_to_file("res://Sequence.tscn")
	GlobalSoundManager.current_audio_player.stop()
	pass # Replace with function body.


func _on_volume_value_changed(value):
	if sound_manager and sound_manager.current_audio_player:
		sound_manager.set_global_volume(value)
		print("Volume set to:", value)

func _on_pitch_value_changed(value):
	if sound_manager and sound_manager.current_audio_player:
		sound_manager.set_global_pitch(value)
		print("Pitch set to:", value)
	pass # Replace with function body.
