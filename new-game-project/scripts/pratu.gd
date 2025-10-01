extends StaticBody3D

var is_open = false
@export var red = 90
@export var def = 0


func interact():
	var target_rotation = def
	if !is_open:
		target_rotation = deg_to_rad(red)
		is_open = true
	else:
		target_rotation = def
		is_open = false

	var tween = create_tween()
	tween.tween_property(self, "rotation:y", target_rotation, 0.7)
