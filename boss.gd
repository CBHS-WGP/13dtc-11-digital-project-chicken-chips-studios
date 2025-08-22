
extends CharacterBody3D
var speed = 2
@onready var player = $"../../Wayne/Enemy detect"
var gravity = 9.81
@onready var nav = $NavigationAgent3D
@onready var target = self
var health = 300
var inhitbox = false

func _process(delta):
	$Damage_Checker/Health_Indicator.text = str(health, "/300")
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
	#boss death/end the game
#	$Damage_Checker/Health_Indicator.text = str(health,"/100")
	if health <= 0:
		Progress.boss_killed = true
		queue_free()
	
func target_position():
	if target == player:
		print("hello")
		nav.set_target_position(player.global_transform.origin)
		look_at(player.global_transform.origin)
		rotation.x = 0
		rotation.z = 0


func _on_inner_detect_area_entered(area: Area3D) -> void:
	if area.is_in_group("playerhitbox"):
		print("entered and hit")
		inhitbox = true
		$AnimationPlayer.play("attac_anim")
		target = player
		
		

#player death
func _on_damage_checker_area_entered(area: Area3D) -> void:
	health = health - 20
	if health < 0:
		queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("hit")
	Global.shot.emit()


#func _on_timer_timeout() -> void:
	#if inhitbox == true:
#		print("hit")
#		$AnimationPlayer.play("attac_anim")
#		Global.shot.emit()
