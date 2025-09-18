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
		Progress.spawn3 = $"Freakboy_Spawns!/StaticBody3D/Floor"

func _process(_delta):
	#this is last minute code to release the freakboys in the map
	#inefficent, but nessesary
	if Progress.current_objective > 2.5:
		$"Freakboy_Spawns!/StaticBody3D/Floor".disabled = true
	else:
		$"Freakboy_Spawns!/StaticBody3D/Floor".disabled = false
	#calls the player position for both enemies (each use a different keyword "position" and "location")
	get_tree().call_group("enemy", "target_position", target.global_transform.origin)
	get_tree().call_group("enemy", "target_location", target.global_transform.origin)
