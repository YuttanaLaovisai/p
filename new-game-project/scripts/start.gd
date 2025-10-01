extends Node3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
