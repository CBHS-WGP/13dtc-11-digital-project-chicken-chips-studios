extends CharacterBody3D

#Variables Below: speed, gravity, health, inhitbox, etc 

@onready var nav = $NavigationAgent3D
var speed = 2
var gravity = 9.81
var health = 100
var inhitbox = false
@onready var player = $"../../Wayne/Enemy detect"
var target = self
var insideinner = false
var insideeyeline = false
const rotation_speed = 5.0

#Func below means that the target will immediately be set to the player so that the enemy will start following the player straight away.
func _ready() -> void:
	target = player

# Code which makes the enemy move towards the player
func _process(delta):
	#Applies gravity if enemy isn't on floor.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
	# Calculates movement direciton and begins moving towards the target (player). Only works if the player is the target because then the speed value is changed.
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * speed
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
# Health code
	$Damage_Checker/Health_Indicator.text = str(health,"/100")
	if health <= 0:
		if Progress.current_objective == 2.6:
			Progress.obj_2_enemies_killed += 1
		queue_free()

# if target equals player and in inner radius, the enemy will rotate towards the player using lerping. The animation will also start playing.
func target_position(delta):
	if target == player:
		if not $FINALFOLLOWERM/AnimationPlayer.is_playing():
			$FINALFOLLOWERM/AnimationPlayer.play("RUNMAIN")
		
		nav.set_target_position(player.global_transform.origin)
		
		#Calculates the players position and how to rotate towards the player.
		var target_pos = $"../../Wayne/Enemy detect".global_transform.origin
		var my_pos = global_transform.origin
		var direction = (target_pos - my_pos).normalized()
		var target_angle = atan2(direction.x, direction.z)
		
		# Rotation + lerping.
		rotation.y = lerp_angle(rotation.y, target_angle + PI, 0.04)
		#Rotation on x and y is locked it can only rotate on the y axis.
		rotation.x = 0
		rotation.z = 0

# This is the hitbox area code - if the player is in the centre hitbox, this code is triggered and thus the player will start to take damage.
func _on_area_3d_area_shape_entered(_area_rid: RID, area: Area3D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.is_in_group("playerhitbox"):
		target = player
		inhitbox = true
		$FINALFOLLOWERM/AnimationPlayer.play("Attack2")

#Turns of the part of the enemy script which does damage to the player once it leaves the enemies inner hitbox.
func _on_area_3d_area_shape_exited(_area_rid: RID, area: Area3D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area != null:
		if area.is_in_group("playerhitbox"):
			target = self
			inhitbox = false
			$FINALFOLLOWERM/AnimationPlayer.stop()
			
# This codes plays every second, if the player area is inside the enemy then hitbox is set to true and the player will start to take damage.
func _on_timer_timeout():
	if inhitbox == true:
		print("hit")
		Global.shot.emit()

# This code allows it so that the M7 bayonet knife can do damage to theplayer
func _on_damage_checker_area_entered(area):
	print("hit")
	if area.is_in_group("M7"):
		health = health - 20


#This is a function that allows for stealth in the game. If crouching is set to true, then this code isn't run, thus it won't follow, thus the stealth aspect.
func _on_crouching_checker_timeout() -> void:
	if insideinner == true and Global.crouching == false:
			target = player
			speed = 2

# If health = 0 the enemy dies.
func dead(_delta):
	if health == 0:
		get_tree().quit()

# Inside inner is set to true, so now the stealth func can run and the enemy may/ may not detect player if it is crouching or not.
func _on_inner_detection_radius_area_entered(area: Area3D) -> void:
	if area.is_in_group("playerhitbox"):
		insideinner = true

# The enemy will stop following the player after a certain radius.
func _on_outer_detection_radius_area_exited(area: Area3D) -> void:
	if area.is_in_group("playerhitbox") and target == player:
		print("exited")
		speed = 0
		target = self
		insideinner = false
		$FINALFOLLOWERM/AnimationPlayer.play("POINT")
		
# The code below is for the enemy eyeline, if the player is in the enemies eyeline the enemy will detect it and will start to move towards the player.
func _on_eyeline_area_entered(area: Area3D) -> void:
	if area.is_in_group("playerhitbox"):
		target = player
		speed = 2
