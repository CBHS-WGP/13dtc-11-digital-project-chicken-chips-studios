extends Node3D

@onready var Bayonetanimation : AnimationTree = $Bayonet/AnimationTree


func _process(delta):
	if Input.is_action_pressed("leftclick"):
		Bayonetanimation["parameters/conditions/swinging == false"] = false
		Bayonetanimation["parameters/conditions/swinging == true"] = true
	else:
		Bayonetanimation["parameters/conditions/swinging == true"] = false
		Bayonetanimation["parameters/conditions/swinging == false"] = true
