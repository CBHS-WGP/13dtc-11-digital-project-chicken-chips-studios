extends CharacterBody3D


@onready var nav = $NavigationAgent3D
var speed = 0
var gravity = 9.81
var health = 100
var inhitbox = false
@onready var player = $"../../Wayne"
var target = self
var insideinner = false

# Code which makes the enemy move towards the player
func _process(delta):
	if not is_on_floor() :
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

# if target equals player and in inner radius, the enemy will follow the player.
func target_position(delta):
	if target == player:
		nav.set_target_position(player.global_transform.origin)
		look_at(player.global_transform.origin)
		rotation.x = 0
		rotation.z = 0

func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("playerhitbox"):
		target = player
		print("hit2")
		inhitbox = true


func _on_area_3d_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, _local_shape_index: int) -> void:
	if area.is_in_group("playerhitbox"):
		target = self
		inhitbox = false



# This codes plays every second, if the player area is inside the enemy then hitbox is set to true and the player will start to take damage.
func _on_timer_timeout():
	if inhitbox == true:
		print("hit")
		Global.shot.emit()

# If player leaves 
func _on_outer_detection_radius_body_exited(body: CharacterBody3D) -> void:
	if body.is_in_group("player"):
		print("exited")
		speed = 0
		target = self


func _on_damage_checker_area_entered(_area):
	health = health - 20




func _on_inner_detection_radius_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") :
		insideinner = true

func _on_crouching_checker_timeout() -> void:
	if insideinner == true and Global.crouching == false:
			target = player
			speed = 2

	
	
func dead(_delta):
	if health == 0:
		get_tree().quit()


func _on_inner_detection_radius_body_exited(body: Node3D) -> void:
	insideinner = false
