extends Node3D

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	SceneTransition.chang_scene("res://scenes/start.tscn")
