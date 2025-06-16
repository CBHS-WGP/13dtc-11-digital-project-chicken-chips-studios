extends Node3D
@onready var target = $Wayne


#light level should be 0.05
#x rotation should be -135.4

func _process(delta):
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)
