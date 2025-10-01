extends CharacterBody3D

@export var speed: float = 3.0
@onready var agent: NavigationAgent3D = $NavigationAgent3D

func _ready():
	randomize()
	pick_new_target()

func _physics_process(delta):
	if agent.is_navigation_finished():
		pick_new_target()
	else:
		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_transform.origin).normalized()
		velocity = direction * speed
		move_and_slide()

func pick_new_target():
	# สุ่มตำแหน่งในแมพ (แกน X,Z)
	var random_point = Vector3(randf_range(-20, 20), 0, randf_range(-20, 20))
	agent.set_target_position(random_point)
