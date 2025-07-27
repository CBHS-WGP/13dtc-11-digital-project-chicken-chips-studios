
extends CharacterBody3D
var speed = 2
@onready var player = $"../../Wayne/Enemy detect"
var gravity = 9.81
@onready var nav = $NavigationAgent3D
@onready var target = self

func _process(delta):
	target_position()
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * speed
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
	
func target_position():
	if target == player:
		print("hello")
		nav.set_target_position(player.global_transform.origin)
		look_at(player.global_transform.origin)
		rotation.x = 0
		rotation.z = 0


func _on_inner_detect_area_entered(area: Area3D) -> void:
	if area.is_in_group("playerhitbox"):
		print("entered")
		target = player
