extends Node3D
@onready var target = $"../Wayne"

func _process2(delta):
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)
