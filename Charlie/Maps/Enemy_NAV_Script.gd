extends Node3D

@onready var target = $Wayne


func _physics_process(_delta):
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)
