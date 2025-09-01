extends Node3D
@onready var target = $"Wayne/Enemy detect"


func _ready():
	if not get_tree().current_scene.is_node_ready():
		await get_tree().current_scene.ready
	else:
		#Sets the path for objectives to be put in later
		Progress.cache_spawn = $Cache_Spawn
		Progress.spawn1 = $Enemy_Spawn1
		Progress.spawn2 = $Enemy_Spawn2
		print(Progress.spawn1)
		print(Progress.spawn2)

func _process(_delta):
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)
	get_tree().call_group("enemy", "target_location", target.global_transform.origin)
