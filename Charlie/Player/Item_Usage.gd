extends Node3D

@onready var Bayonetanimation : AnimationTree = $M7_Bayonet/Bayonet/AnimationTree
@onready var Gun_Animation : AnimationTree = $G32/G32Gun/GunTree
@onready var Explosion = preload("res://Charlie/Specific Objective files/small_explosion.tscn")
@export var Test_Map = preload("res://Charlie/Maps/Test_Map.tscn")

#gun raycast varibles
var hit = null
var ray
var pos = Vector3()

func _ready():
	#resetting the gun animation state (needs this to work the first time for some reason?)
	Gun_Animation["parameters/conditions/focus"] = true
	Gun_Animation["parameters/conditions/unfocus"] = false

func _process(delta):
	
	#Code that allows the animation tree to paly the correct animation, and thus be able to use
	#the knife.
	if Global.equipped_item_id == str("null"):
		_hiding()

	elif Global.equipped_item_id == str("M7 Bayonet"):
		_hiding()
		$M7_Bayonet.visible = true
		if Global.inv_open == false and Global.settings_open == false:
			if Input.is_action_pressed("leftclick"):
				Bayonetanimation["parameters/conditions/swinging == false"] = false
				Bayonetanimation["parameters/conditions/swinging == true"] = true
			else:
				Bayonetanimation["parameters/conditions/swinging == true"] = false
				Bayonetanimation["parameters/conditions/swinging == false"] = true
	
	
	elif Global.equipped_item_id == str("G32 Pistol"):
		_hiding()
		$G32.visible = true
		ray = $G32/G32Gun/Gun_Cast
		if Global.inv_open == false and Global.settings_open == false:
			if Input.is_action_just_pressed("leftclick") and Global.G32_bullets_in_mag > 0:
				Global.G32_bullets_in_mag -= 1
				$G32/G32Gun/G32.pitch_scale = randf_range(0.85, 1.10)
				$G32/G32Gun/G32.play()
				_shoot()
			if Input.is_action_just_pressed("rightclick"):
				Gun_Animation["parameters/conditions/focus"] = false
				Gun_Animation["parameters/conditions/unfocus"] = true
			elif Input.is_action_just_released("rightclick"):
				Gun_Animation["parameters/conditions/focus"] = true
				Gun_Animation["parameters/conditions/unfocus"] = false
		elif Global.inv_open == true or Global.settings_open == true:
			Gun_Animation["parameters/conditions/focus"] = true
			Gun_Animation["parameters/conditions/unfocus"] = false
		
		if Input.is_action_just_pressed("R") and Global.G32_bullets_in_mag < 12 and Global.inv_open == false and Global.settings_open == false:
			var Temp_Array = _bullet_calculator(Global.G32_bullets_in_mag, Global.G32_bullets, 12)
			Global.G32_bullets_in_mag = Temp_Array[0]
			Global.G32_bullets = Temp_Array[1]
	elif Global.equipped_item_id == str("Sattelite_Box"):
		_hiding()
		$Cube.visible = true
		
	elif Global.equipped_item_id == str("P90"):
		_hiding()
		$P90.visible = true
		ray = $P90/P90_Gun_Cast
		if Input.is_action_just_pressed("R") and Global.P90_bullets_in_mag < 50 and Global.inv_open == false and Global.settings_open == false:
			var Temp_Array = _bullet_calculator(Global.P90_bullets_in_mag, Global.P90_bullets, 50)
			Global.P90_bullets_in_mag = Temp_Array[0]
			Global.P90_bullets = Temp_Array[1]



func _hiding():
		for child in get_children():
			child.visible = false

#Used by BOTH guns to calculate reloading
func _bullet_calculator(in_mag, current, max) -> Array:
	#when the gun is already full
	if current <= 0:
		pass
	#Reloading the gun as normal
	if max - in_mag > current:
		in_mag = in_mag + current
		current = 0
		#print([in_mag, current, max])
		return [in_mag, current, max]
	#Edge case for when there arnt enough bullets to fully fill the gun
	else:
		current = current - (max - in_mag)
		in_mag = max
		#print([in_mag, current, max])
		return [in_mag, current, max]
	

func _shoot():
	if ray.is_colliding():
		hit = ray.get_collider()
		pos = Vector3(ray.get_collision_point())
		print(ray.get_collider().global_position)
		var instance = Explosion.instantiate()
		instance.position = Vector3(pos)
		#gets the main scene tree and put thi instance under the main node
		#This is done so it is based on global position instead of being
		#relative to player position
		get_tree().get_root().add_child(instance)
		#Sets the actual position
		instance.global_position = ray.get_collider().position
		#Enemy damage if nessesary
		print(hit.get_collision_mask())
		if hit.get_collision_mask() == 64:
			hit.get_parent().health = hit.get_parent().health - 15
		else:
			print("poke")


func _on_p_90_shoot_timer_timeout() -> void:
	if Global.equipped_item_id == str("P90"):
		if Input.is_action_pressed("leftclick") and Global.P90_bullets_in_mag > 0  and Global.inv_open == false and Global.settings_open == false:
			$"P90/Proto_Muzzle_flash".play("flash")
			$P90/Shoot.pitch_scale = randf_range(0.90, 1.10)
			$P90/Shoot.play()
			Global.P90_bullets_in_mag -= 1
			_shoot()
		
