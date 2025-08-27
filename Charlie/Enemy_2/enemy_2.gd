extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
const SPEED = 2.5
const GRAVITY = 9.81
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0

	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity.x = velocity.move_toward(new_velocity, 0.25)[0]
	#velocity.y = velocity.move_toward(new_velocity, 0.25)[1]
	velocity.z = velocity.move_toward(new_velocity, 0.25)[2]
	move_and_slide()

func target_location(target_location):
	nav_agent.set_target_position(target_location)
	
