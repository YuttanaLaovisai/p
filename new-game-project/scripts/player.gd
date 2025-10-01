extends CharacterBody3D

@onready var pivot = $Pivot
@onready var camera = $Pivot/Camera3D
@onready var raycast = $Pivot/Camera3D/RayCast3D
@onready var crosshair = $Label
@onready var part = $part

var yaw = 0.0
var pitch = 0.0

@export var speed = 2
var is_jumping = false
var sens = 0.002

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * sens
		pitch -= event.relative.y * sens
		pitch = clamp(pitch, deg_to_rad(-80), deg_to_rad(90))
		rotation.y = yaw
		pivot.rotation.x = pitch


func _process(delta: float) -> void:
	
	part.text = "Find all the car parts \n– Tires: "+str(GlobalInventory.tire)+"/4\n– Fuel: "+str(GlobalInventory.fuel)+"/1."
	
	if Input.is_action_just_pressed("shift"):
		speed *= 2
	if Input.is_action_just_released("shift"):
		speed /= 2

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	if Input.is_action_just_pressed("space") and is_on_floor():
		is_jumping = true
		velocity.y = 4.5

	if not is_on_floor() and !is_jumping and velocity.y < 0:
		is_jumping = true

	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()
	
	var collision = raycast.get_collider()

	if raycast.is_colliding() and collision != null and collision.has_method("interact"):
		crosshair.visible = true
		if Input.is_action_just_pressed("click"):
			collision.interact()
	else:
		crosshair.visible = false
