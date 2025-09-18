extends Node3D
@onready var target = $"Wayne/Enemy detect"

#Updates the target position relative to the enemy.
func _process(delta):
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)
