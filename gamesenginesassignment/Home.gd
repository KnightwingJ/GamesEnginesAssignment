extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_home_pressed():
	get_tree().change_scene_to_file("res://Sequence.tscn")
	pass # Replace with function body.


func _on_volume_value_changed(value):
	print("Volume: ",value)
	pass # Replace with function body.


func _on_bpm_value_changed(value):
	print("BPM: ",value)
	pass # Replace with function body.


func _on_pitch_value_changed(value):
	print("Pitch: ",value)
	pass # Replace with function body.
