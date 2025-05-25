extends Node3D

const RAY_LENGTH = 10

func _process(_delta):
	var space_state = get_world_3d().direct_space_state
	var cam = get_parent().get_parent().get_node("Camera/Camera")
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	#print(result)
	
