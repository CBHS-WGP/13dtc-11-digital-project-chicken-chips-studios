extends Node3D

@onready var Bayonetanimation : AnimationTree = $M7_Bayonet/Bayonet/AnimationTree


func _process(_delta):
	#Code that allows the animation tree to paly the correct animation, and thus be able to use
	#the knife.
	if Global.inv_open == false and Global.settings_open == false:
		if Input.is_action_pressed("leftclick"):
			Bayonetanimation["parameters/conditions/swinging == false"] = false
			Bayonetanimation["parameters/conditions/swinging == true"] = true
		else:
			Bayonetanimation["parameters/conditions/swinging == true"] = false
			Bayonetanimation["parameters/conditions/swinging == false"] = true
