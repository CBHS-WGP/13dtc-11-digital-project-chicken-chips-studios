extends Node3D
@onready var target = $"Wayne/Enemy detect"

func _ready():
	if not get_tree().current_scene.is_node_ready():
		await get_tree().current_scene.ready
	else:
		#Sets the path for objectives to be put in later
		Progress.spawn = $Enemy_Spawn
		Progress.cache_spawn = $Cache_Spawn


func _process(delta):
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)
