extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = $"../../Wayne/Enemy detect"
@onready var launcher = $Launcher/Looking_for_Target
var hit
var animate = false
var current_location
var next_location
var new_velocity
var pos
var health = 20
const SPEED = 4
const GRAVITY = 9.81
func _ready() -> void:
	$Model/Freakboy/AnimationPlayer.play("Ball")

func _physics_process(delta: float) -> void:
	$Model/Freakboy.rotation.x = $Model/Freakboy.rotation.x + 0.08
	if jump_ray(animate) == true:
		#print("jumping")
		#velocity.x = pos[0] * 0.05
		#velocity.z = pos[2] * 0.05
		if global_position[1] > pos[1]:
			velocity.y -= GRAVITY * delta
		else:
			velocity.y = 0
			global_position[1] = pos[1]
			animate = false
	else:
		current_location = global_transform.origin
		next_location = nav_agent.get_next_path_position()
		new_velocity = (next_location - current_location).normalized() * SPEED
		velocity.x = velocity.move_toward(new_velocity, 0.25)[0]
		velocity.z = velocity.move_toward(new_velocity, 0.25)[2]
		if current_location.y <= new_velocity[1]:
			velocity.y = 0
		else:
			velocity.y -= GRAVITY * delta
	
	#having on ly the actual model mode to look at the player
	$Model.look_at(player.global_position)
	$Launcher.look_at(player.global_position)
	move_and_slide()

func target_location(target_location):
	nav_agent.set_target_position(target_location)
	
func jump_ray(animate):
	if launcher.is_colliding():
		hit = launcher.get_collider()
		pos = player.global_position
		velocity.y = SPEED
		return true
		
