extends CharacterBody3D

@onready var pivot = $Pivot
@onready var camera = $Pivot/Camera3D

var yaw = 0.0
var pitch = 0.0

@export var speed = 5.0
var is_jumping = false
@onready var anim = $body/AnimationPlayer
var sens = 0.002

func _ready() -> void:
	if not anim.is_playing():
		anim.play("Idle", 0.2)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * sens
		pitch -= event.relative.y * sens
		pitch = clamp(pitch, deg_to_rad(-40), deg_to_rad(20))
		rotation.y = yaw
		pivot.rotation.x = pitch


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shift"):
		speed *= 2
	if Input.is_action_just_released("shift"):
		speed /= 2

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): 
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("space") and is_on_floor():
		is_jumping = true
		anim.play("Jump_Start", 1)
		anim.queue("Jump")   
		velocity.y = 4.5

	if not is_on_floor() and !is_jumping and velocity.y < 0:
		is_jumping = true
		anim.play("Jump", 1)  

	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if not is_jumping:
		if direction:
			if input_dir.y < 0: 
				if Input.is_action_pressed("shift"):
					anim.play("Sprint", 3)
				else:
					anim.play("Walk", 3)
			if input_dir.x != 0: 
				if Input.is_action_pressed("shift"):
					anim.play("Sprint", 3)
				else:
					anim.play("Walk", 3)
			
			elif input_dir.y > 0:
				anim.play_backwards("Walk", 3) 

		else:
			anim.play("Idle", 1)

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()

	if is_on_floor() and is_jumping and velocity.y <= 0:
		anim.play("Jump_Land", 0.3)
		is_jumping = false
