extends CharacterBody3D


@onready var nav = $NavigationAgent3D
var speed = 0
var gravity = 9.8
var health = 100


# Code which makes the enemy move towards the player
func _process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * speed
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
	
	$Damage_Checker/Health_Indicator.text = str(health,"/100")
	if health <= 0:
		Progress.objective_1 = Progress.objective_1 + 1
		queue_free()
	
func target_position(target):
	nav.set_target_position(target)
	look_at(target)




func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	if body.is_in_group("player"):
		print("hit")
#		"res://Global.gd".hit()



# If player leaves 
func _on_outer_detection_radius_body_exited(body: CharacterBody3D) -> void:
	if body.is_in_group("player"):
		print("exited")
		speed = 0


func _on_damage_checker_area_entered(area):
	health = health - 20




func _on_inner_detection_radius_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("entered")
		speed = 2
