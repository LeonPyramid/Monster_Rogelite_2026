extends CharacterBody3D

@export_group("Movement")
# How fast the player moves in meters per second.
@export var max_speed = 14

## it felt better to leave it in.
@export var acceleration: float = 500.0

@export var dash_speed:float = 100.0

@export var dash_decelatation_time = 1.0

var target_velocity = Vector3.ZERO

var _cur_max_speed

var _child_mesh_3d:MeshInstance3D

@export_group("Smoke")

@export var smoke_particle:Mesh

var some_particle_list:Array[MeshInstance3D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_cur_max_speed = max_speed
	_child_mesh_3d = get_node("MeshInstance3D")
	pass # Replace with function body.

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var input_dir :=  Input.get_vector("move_left", "move_right", "move_up", "move_down").rotated(deg_to_rad(-45))
	_child_mesh_3d.rotation.y = - input_dir.angle() + PI/2;
	if input_dir != Vector2.ZERO:
		velocity += Vector3(input_dir.x,0,input_dir.y) * _adjusted_acceleration(delta)
		if Input.is_action_just_pressed("dash") && _cur_max_speed == max_speed:
			print_debug("dashed")
			velocity = Vector3(input_dir.x,0,input_dir.y) * dash_speed
			_cur_max_speed = max_speed + dash_speed
			create_tween().tween_property(self, "_cur_max_speed", max_speed, dash_decelatation_time)

	else:
		# Reduce the length of our velocity vector by a linear amount each frame, based on our
		# "adjusted acceleration". If this number ever goes into the negative, we'd reverse direction
		# and we'd "flicker" back and forth every physics frame, so let's make sure we never
		# go into the negative.
		var new_length = max(0, velocity.length() - _adjusted_acceleration(delta))
		velocity = velocity.normalized() * new_length
	# Don't exceed the maximum speed
	velocity = velocity.limit_length(_cur_max_speed)

	# Moving the Character
	#velocity = target_velocity
	move_and_slide()

func _adjusted_acceleration(delta: float) -> float:
	return acceleration * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
