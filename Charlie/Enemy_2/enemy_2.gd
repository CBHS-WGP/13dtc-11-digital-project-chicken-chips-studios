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
var health = 20
var on_floor = false
const SPEED = 4
const GRAVITY = 9.81
func _ready() -> void:
	launcher.enabled = true
	$Model/Freakboy/AnimationPlayer.play("Ball")

func _physics_process(delta: float) -> void:
	print(animate)
	$Model/Freakboy.rotation.x = $Model/Freakboy.rotation.x + 0.08
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
		current_location = global_transform.origin
		next_location = nav_agent.get_next_path_position()
		new_velocity = (next_location - current_location).normalized() * SPEED
		velocity.x = velocity.move_toward(new_velocity, 0.25)[0]
		velocity.z = velocity.move_toward(new_velocity, 0.25)[2]
		#ajust upwards y
		#ajust downwards y (buggy)
		if floor.is_colliding() == false:
			velocity.y -= GRAVITY * delta
		else:
			velocity.y = 0
	
	#having on ly the actual model mode to look at the player
	$Model.look_at(player.global_position)
	$Launcher.look_at(player.global_position)
	move_and_slide()

func target_location(target_location):
	nav_agent.set_target_position(target_location)
	
func jump_ray():
	if launcher.is_colliding() and launcher.enabled == true:
		print("scan")
		hit = launcher.get_collider()
		pos = player.global_position
		velocity.y = SPEED * 1.5
		velocity.x = velocity[0] * 1.5
		velocity.z = velocity[2] * 1.5
		launcher.enabled = false
		animate = true

func floor_ray():
	print(floor.is_colliding())
	if floor.is_colliding():
		on_floor = true
		velocity.y = 0
		pos = floor.get_collision_point()
		if pos[1] < floor.position[1]:
			global_position[1] = global_position[1] + (pos[1] -  0.2)
