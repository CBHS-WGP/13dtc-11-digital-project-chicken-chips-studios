extends Area3D
var obj_name = name

signal OnItemPickedUp(item)

func _process(delta):
	#print(Progress.current_objective)
	if Input.is_action_pressed("F") and Global.current_raycast == name:
		
		#Specific Sattelite activation code
		if Global.current_raycast == "Sattelite" and Progress.current_objective == 2.5:
			Progress.sattelite_activated = true
			Progress.current_objective = Progress.current_objective + 0.5
		
		#Specific Sattelite Box code
		if Global.current_raycast == "Sattelite_Box":
			Progress.current_objective = Progress.current_objective + 0.5
			queue_free()
		
		#Specific Sphere cade
		if Global.current_raycast == "Area3D":
			queue_free()

func _add_item():
	pass
func emit_away():
	OnItemPickedUp.emit(Global.current_raycast)
	queue_free()
	
