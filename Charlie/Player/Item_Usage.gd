extends Node3D

@onready var Bayonetanimation : AnimationTree = $M7_Bayonet/Bayonet/AnimationTree
@onready var Gun_Animation : AnimationTree = $G32/G32Gun/GunTree
@onready var Explosion = preload("res://Charlie/Specific Objective files/small_explosion.tscn")
var selection = 0

#gun raycast varibles
var hit = null
var ray
var gun_raycast

func _ready():
	#resetting the gun animation state (needs this to work the first time for some reason?)
	Gun_Animation["parameters/conditions/focus"] = true
	Gun_Animation["parameters/conditions/unfocus"] = false
	ray = $G32/Gun_Cast

func _process(_delta):

	#Code that allows the animation tree to paly the correct animation, and thus be able to use
	#the knife.
	if selection == 0:
		_hiding()

	if Global.equipped_item_id == str("M7 Bayonet"):
		_hiding()
		$M7_Bayonet.visible = true
		if Global.inv_open == false and Global.settings_open == false:
			if Input.is_action_pressed("leftclick"):
				Bayonetanimation["parameters/conditions/swinging == false"] = false
				Bayonetanimation["parameters/conditions/swinging == true"] = true
			else:
				Bayonetanimation["parameters/conditions/swinging == true"] = false
				Bayonetanimation["parameters/conditions/swinging == false"] = true
	
	
	if Global.equipped_item_id == str("G32 Pistol"):
		_hiding()
		$G32.visible = true
		if Global.inv_open == false and Global.settings_open == false:
			if Input.is_action_just_pressed("leftclick"):
				_shoot()
			if Input.is_action_just_pressed("rightclick"):
				Gun_Animation["parameters/conditions/focus"] = false
				Gun_Animation["parameters/conditions/unfocus"] = true
			elif Input.is_action_just_released("rightclick"):
				Gun_Animation["parameters/conditions/focus"] = true
				Gun_Animation["parameters/conditions/unfocus"] = false
	
	
	if Global.equipped_item_id == str("Sattelite_Box"):
		_hiding()
		$Cube.visible = true
		

func _hiding():
		for child in get_children():
			child.visible = false
func _shoot():
	#print(gun_raycast)
	if ray.is_colliding():
		hit = ray.get_collider()
		#Explosion.global_position = ray.get_collider().global_position
		#add_child(Explosion)
		print(ray.get_collider().global_position)
		hit.get_parent().health = hit.get_parent().health - 15
		gun_raycast = hit.name
	else:
		Global.current_raycast = null
