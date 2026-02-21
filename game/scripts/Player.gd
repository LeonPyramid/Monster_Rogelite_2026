extends CharacterBody3D

@export_group("Movement")
# How fast the player moves in meters per second.
@export var max_speed = 14

## it felt better to leave it in.
@export var acceleration: float = 500.0

@export var dash_speed:float = 100.0

var target_velocity = Vector3.ZERO



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var input_dir :=  Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_dir != Vector2.ZERO:
		velocity += Vector3(input_dir.x,0,input_dir.y) * _adjusted_acceleration(delta)
		if Input.is_action_just_pressed("dash"):
			print_debug("dashed")
			velocity += Vector3(input_dir.x,0,input_dir.y) * dash_speed
	
	else:
		# Reduce the length of our velocity vector by a linear amount each frame, based on our
		# "adjusted acceleration". If this number ever goes into the negative, we'd reverse direction
		# and we'd "flicker" back and forth every physics frame, so let's make sure we never
		# go into the negative.
		var new_length = max(0, velocity.length() - _adjusted_acceleration(delta))
		velocity = velocity.normalized() * new_length
	# Don't exceed the maximum speed
	if Input.is_action_just_pressed("dash"):
		velocity = velocity.limit_length(max_speed+dash_speed)
		
	else:
		velocity = velocity.limit_length(max_speed)

	# Moving the Character
	#velocity = target_velocity
	move_and_slide()

func _adjusted_acceleration(delta: float) -> float:
	return acceleration * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
