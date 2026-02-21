extends CharacterBody3D


# How fast the player moves in meters per second.
@export var speed = 14


var target_velocity = Vector3.ZERO



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	#target_velocity = input_dir * speed
	target_velocity.x = input_dir.x * speed
	target_velocity.z = input_dir.y * speed


	# Moving the Character
	velocity = target_velocity
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
