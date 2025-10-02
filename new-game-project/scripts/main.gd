extends Node3D

@onready var player = $player

func _ready() -> void:
	if !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()

func _process(delta: float) -> void:
	if player.position.y < -20:
		player.position = Vector3(0, 10, 0)


#func _on_area_3d_body_entered(body: Node3D) -> void:
	#$phee
