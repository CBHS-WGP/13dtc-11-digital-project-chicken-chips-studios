#Variables Below: speed, gravity, health, inhitbox, etc 
extends CharacterBody3D
var speed = 2
@onready var player = $"../../Wayne/Enemy detect"
var gravity = 9.81
@onready var nav = $NavigationAgent3D
@onready var target = self
var health = 300
var inhitbox = false

# Code which makes the boss move towards the player
func _process(delta):
	#health bar
	$Damage_Checker/Health_Indicator.text = str(health, "/300")
	target_position()
	#Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * speed
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
	#boss death/end the game
#	$Damage_Checker/Health_Indicator.text = str(health,"/100")
	if health <= 0:
		Progress.boss_killed = true
		queue_free()
		
# if target equals player and in inner radius, the boss will rotate towards the player using lerping. The animation will also start playing.
func target_position():
	if target == player:
		nav.set_target_position(player.global_transform.origin)
		var target_pos = $"../../Wayne/Enemy detect".global_transform.origin
		var my_pos = global_transform.origin
		
		var direction = (target_pos - my_pos).normalized()
		var target_angle = atan2(direction.x, direction.z)
		
		rotation.y = lerp_angle(rotation.y, target_angle + PI, 0.04)
		
		rotation.x = 0
		rotation.z = 0

# This is the hitbox area code - if the player is in the centre hitbox, this code is triggered and thus the player will start to take damage.
func _on_inner_detect_area_entered(area: Area3D) -> void:
	if area.is_in_group("playerhitbox"):
		print("entered and hit")
		inhitbox = true
		$AnimationPlayer.play("attac_anim")
		target = player
		
		

#Boss death
func _on_damage_checker_area_entered(area: Area3D) -> void:
	health = health - 20
	if health < 0:
		queue_free()

#Doing damage to the player if it is in the boss hitbox.
func _on_area_3d_body_entered(body: Node3D) -> void:
	print("hit")
	Global.shot.emit()
