extends CharacterBody3D

#shorthand noready varibles that allow for easier code readability, and is more flexible
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
var finding_floor = false
var can_jump = true
#an array of bools, set to 11 parameters long
@export var shouldjump = Array([], TYPE_BOOL, "", false )
const SPEED = 4
const GRAVITY = 9.81

func _ready() -> void:
	launcher.enabled = true

func _physics_process(delta: float) -> void:
	#function that runs every frame, updating if the player has been on the floor at all for the past 10 frames
	#extra overflow section in the array so the game doesnt crash
	shouldjump[10] = false
	#sets the first slot in the array to if the player is on the floor
	shouldjump[0] = on_floor
	#moves all values up by one, except for the overflow section.
	for i in range(shouldjump.size() - 1, 0, -1):
		shouldjump[i] = shouldjump[i - 1] 
	
	$Launcher/Health_Indicator.text = str(health, "/40")
	#enemy death
	if health <= 0:
		queue_free()

	#Important subroutines to have the enemy have gravity and it jump ability.
	jump_ray()
	floor_ray()
	#Jump ray defines if the enemy is animating (jumping in the air)
	if animate == true:
		#add gravity if not on floor
		if  on_floor == false:
			velocity.y -= GRAVITY * delta
		#if on ground animate off, and stop all gravity, the enemy has hit the ground
		else:
			velocity.y = 0
			launcher.enabled = true
			animate = false
	else:
		#when the enemy is on the ground he will roll toard as usual
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
		#nessesary backup gravity for specific cases which i found while testing
		if on_floor == false:
			velocity.y -= GRAVITY * delta

	
	#have the laucher look at the player (to check if hes near)
	$Launcher.look_at(player.global_position)
	move_and_slide()

func target_location(target_location):
	nav_agent.set_target_position(target_location)
	




func jump_ray():
	#If the enemy raycast is colliding with the player and isnt on cooldown, start jumping
	if launcher.is_colliding() and launcher.enabled == true and can_jump == true:
		#edits the animation tree conditions to edit the state.
		$Model/Freakboy/Smooth_Animation["parameters/conditions/rotate"] = false
		$Model/Freakboy/Smooth_Animation["parameters/conditions/attack"] = true
		$Launcher/Unstick_Enemy.start()
		#this code can go after the animation without error as the if statement
		#only check for if there is any kind of collison, as the raycast is on layer 3
		#the only other object it can collide with is the player. 
		hit = launcher.get_collider()
		pos = player.global_position
		launcher.enabled = false
		animate = true
		
		finding_floor = false
		#sets the model to face the player on the x and z axis.
		$Model/Freakboy.rotation = lerp(Vector3($Model/Freakboy.rotation), Vector3(0, 24, 0), 0.1)
		#starting the timers to ensure the jump and floor collisions are turned off for a bit.
		$Launcher/Launch_Delay.start()
		$"Launcher/Stop overlap".start()
		#sets the jump speed and increases the horizontal movement to give a lurch effect.
		velocity.y = SPEED
		velocity.x = velocity[0] * 1.03
		velocity.z = velocity[2] * 1.03
		can_jump = false

func floor_ray():
	#code that checks for the floor on layer one, excluding the player.
	if floor.is_colliding() == true and floor.get_collider().name != str("Wayne") and finding_floor == true:
		#sets the player as on the floor and stops y movement
		on_floor = true
		velocity.y = 0
		#collecting the collision point to run tests each frame to check overlap between
		#the raycast and the floor in the next few lines
		pos = floor.get_collision_point()
		#if the collision point of the raycast is is intercepting whatso ever
		#prop up the enemy on the y axis to sit cleanly on the floor, this stops
		#the enemy from sinking into the ground as the tip of the raycast is on the bottom of the enemy.
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
	#this code runs after the timer finishes
	# This timer starts when the player first jumps
	var amount = 0
	#using the shouldjump array from the top of the process script the enemy checks to see
	#if hes been off the ground for at least 9 of 10 of the last 10 frames
	#if all 10 say false, he jumps, otherwise he doesnt
	#this stops random jumping if he happens to fall down a small surface that is less than 10 frames
	for i in range(shouldjump.size() - 1):
		print(shouldjump[i])
		if shouldjump[i - 1] == false:
			amount = amount + 1
	print(amount)
	#changes back the conditions to rolling as hes not attacking, hes just jumping
	#NOTE: extra collider is nessesary to stop the enemy from jumping in the air if he were to go high in the sky (try to remedy double jumps).
	if can_jump == true and finding_floor == true and amount >= 9 and $Launcher/General_Floor_extra_check.is_colliding() == true:
		$Model/Freakboy/Smooth_Animation["parameters/conditions/rotate"] = true
		$Model/Freakboy/Smooth_Animation["parameters/conditions/attack"] = false
		#apply a large jump thats larger than the player, to unstick.
		velocity.y = SPEED * 2


func _on_bayonet_damage_checker_area_entered(area):
	#bayonet damage (as its different to gun damage)
	health = health - 20


func _on_attacking_player_area_entered(area: Area3D):
	#Dealing damage to the player based on the attacking collision.
	if area.is_in_group("playerhitbox"):
		Global.shot_small.emit()
