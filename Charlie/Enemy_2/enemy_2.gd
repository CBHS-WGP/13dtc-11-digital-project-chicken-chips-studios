extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = $"../../Wayne/Enemy detect"
@onready var launcher = $Launcher/Looking_for_Target
@onready var floor = $Launcher/Floor_Search
var hit
var animate = false
var current_location
var next_location
var new_velocity
var pos
var health = 40
var on_floor = false
var finding_floor = true
var can_jump = true
const SPEED = 4
const GRAVITY = 9.81
func _ready() -> void:
	launcher.enabled = true
	$Model/Freakboy/AnimationPlayer.play("Ball")

func _physics_process(delta: float) -> void:
	
	if health <= 0:
		queue_free()
	
	$"Bayonet damage checker/Health_Indicator".text = str(health, "/40")
	jump_ray()
	floor_ray()
	if animate == true:
		#velocity.x = pos[0] * 0.05
		#velocity.z = pos[2] * 0.05
		if  on_floor == false:
			velocity.y -= GRAVITY * delta
		#if global_position[1] >= pos[1]:
			#velocity.y -= GRAVITY * delta
		else:
			velocity.y = 0
			launcher.enabled = true
			animate = false
	else:
		$Model/Freakboy/Smooth_Animation["parameters/conditions/rotate"] = true
		$Model/Freakboy/Smooth_Animation["parameters/conditions/attack"] = false
		#have the model face and rotate the correct direction
		$Model.look_at(player.global_position, Vector3(0, player.global_position[1], 0))
		$Model/Freakboy.rotation.x = $Model/Freakboy.rotation.x + 0.08
		current_location = global_transform.origin
		next_location = nav_agent.get_next_path_position()
		new_velocity = (next_location - current_location).normalized() * SPEED
		velocity.x = velocity.move_toward(new_velocity, 0.25)[0]
		velocity.z = velocity.move_toward(new_velocity, 0.25)[2]
		if on_floor == false:
			velocity.y -= GRAVITY * delta

	
	#having on ly the actual model mode to look at the player
	$Launcher.look_at(player.global_position)
	move_and_slide()

func target_location(target_location):
	nav_agent.set_target_position(target_location)
	




func jump_ray():
	if launcher.is_colliding() and launcher.enabled == true and can_jump == true:
		$Model/Freakboy/Smooth_Animation["parameters/conditions/rotate"] = false
		$Model/Freakboy/Smooth_Animation["parameters/conditions/attack"] = true
		$Launcher/Unstick_Enemy.start()
		hit = launcher.get_collider()
		pos = player.global_position
		launcher.enabled = false
		animate = true
		
		#starting the timers to ensure the jump and floor collisions are turned off for a bit.
		finding_floor = false
		$Model/Freakboy/AnimationPlayer.play("Attack_001")
		$Model/Freakboy.rotation = lerp(Vector3($Model/Freakboy.rotation), Vector3(0, 24, 0), 0.1)
		$Launcher/Launch_Delay.start()
		$"Launcher/Stop overlap".start()
		velocity.y = SPEED
		velocity.x = velocity[0] * 1.03
		velocity.z = velocity[2] * 1.03
		can_jump = false

func floor_ray():
	if floor.is_colliding() == true and floor.get_collider().name != str("Wayne") and finding_floor == true:
		on_floor = true
		velocity.y = 0
		pos = floor.get_collision_point()
		if pos[1] < floor.position[1]:
			global_position[1] = move_toward(global_position[1], global_position[1] + (pos[1] + 1.15 + 0.639 + 0.301), 0.01)
	else:
		on_floor = false

func _on_stop_overlap_timeout() -> void:
	finding_floor = true
	


func _on_launch_delay_timeout() -> void:
	can_jump = true

#enemy sometimes gets stuck on player, this should make him jump off
func _on_unstick_enemy_timeout() -> void:
	if can_jump == true and finding_floor == true and on_floor == false:
		$Model/Freakboy/Smooth_Animation["parameters/conditions/rotate"] = true
		$Model/Freakboy/Smooth_Animation["parameters/conditions/attack"] = false
		velocity.y = SPEED * 2


func _on_bayonet_damage_checker_area_entered(area: Area3D):
	health = health - 20
