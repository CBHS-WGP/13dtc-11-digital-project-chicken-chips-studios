extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
const SPEED = 2
const GRAVITY = 9.81
func _physics_process(delta: float) -> void:
	if is_on_floor() == false and is_on_wall() == false:
		velocity.y -= GRAVITY * delta

	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED

	velocity = velocity.move_toward(new_velocity, .25)
	move_and_slide()

func target_location(target_location):
	nav_agent.set_target_position(target_location)
	
