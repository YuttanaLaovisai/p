extends Node3D

@onready var player = $player

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if player.position.y < -20:
		player.position = Vector3(0, 10, 0)
