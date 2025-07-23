
extends CharacterBody3D
var speed = 0
var player
var gravity = 9.81
@onready var nav = $NavigationAgent3D
@onready var target = $"../../Wayne/Enemy detect"

func _process(delta):
	#print(global_position.y)
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * speed
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
	
func target_position(_delta):
	if target == player:
		nav.set_target_position(player.global_transform.origin)
		look_at(player.global_transform.origin)
		rotation.x = 0
		rotation.z = 0
