extends Node3D

var hit = null

func _process(delta: float) -> void:
	var ray = $Pickup
	if ray.is_colliding():
		hit = ray.get_collider()
		print(hit.name)
		Global.current_raycast = hit.name
	else:
		Global.current_raycast = null


	
