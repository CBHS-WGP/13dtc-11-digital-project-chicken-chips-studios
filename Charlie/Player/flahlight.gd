extends Node3D

var flashlight_rotation_smoothness := 15.0
var flashlight_position_smoothness := 15.0
@onready var cam: Node3D = $".."
@onready var flashlight = self

func _process(delta):
	#update_flashlight(delta)
	
	
	if Input.is_action_just_pressed("flashlight") and $Flashlight.is_playing() == false:
		if Global.flashlight_out == false:
			$Flashlight.play("up")
			Global.flashlight_out = true
		else:
			$Flashlight.play("down")
			Global.flashlight_out = false
			

func update_flashlight(delta: float) -> void:
	flashlight.global_transform = Transform3D(
		flashlight.global_transform.basis.slerp(cam.global_transform.basis, delta * flashlight_rotation_smoothness),
		flashlight.global_transform.origin.slerp(cam.global_transform.origin, delta * flashlight_position_smoothness)
	)
