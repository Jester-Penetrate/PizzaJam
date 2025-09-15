extends CharacterBody2D


@export var speed = 200.0
@export var acceleration = 1000
@export var friction = 1000
@export var jump_velocity = -400.0


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	jump()
	var input_axis := Input.get_axis("ui_left", "ui_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	move_and_slide()
	
func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, input_axis * speed, acceleration * delta)

func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

func jump():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_velocity
	else:
		if Input.is_action_just_released("ui_accept") and velocity.y < jump_velocity/2:
			velocity.y = jump_velocity/2

	
