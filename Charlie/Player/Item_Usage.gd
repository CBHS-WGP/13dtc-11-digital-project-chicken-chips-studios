extends Node3D

@onready var Bayonetanimation : AnimationTree = $M7_Bayonet/Bayonet/AnimationTree
@onready var Gun_Animation : AnimationTree = $G32/G32Gun/GunTree
@onready var Explosion = preload("res://Charlie/Specific Objective files/small_explosion.tscn")
@export var Test_Map = preload("res://Charlie/Maps/Test_Map.tscn")
var selection = 0

#gun raycast varibles
var hit = null
var ray
var pos = Vector3()

func _ready():
	#resetting the gun animation state (needs this to work the first time for some reason?)
	Gun_Animation["parameters/conditions/focus"] = true
	Gun_Animation["parameters/conditions/unfocus"] = false
	ray = $G32/G32Gun/Gun_Cast

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
			if Input.is_action_just_pressed("leftclick") and Global.pistol_bullets > 0:
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
	
	if Global.equipped_item_id == str("Sattelite_Box"):
		_hiding()
		$Cube.visible = true
		

func _hiding():
		for child in get_children():
			child.visible = false
func _shoot():
	Global.pistol_bullets -= 1
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
		if hit.get_collision_mask() == 64:
			hit.get_parent().health = hit.get_parent().health - 15
		else:
			print("poke")
