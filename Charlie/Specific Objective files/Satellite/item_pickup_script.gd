extends Area3D

<<<<<<< Updated upstream
signal OnItemPickedUp(item)
@onready var raycast = preload("res://Charlie/Player/pickup_ray.gd")
func _process(delta):
	#print(Global.current_raycast)
	if Input.is_action_pressed("F") and Global.current_raycast == name:
		
		#Specific Sattelite activation code
		if Global.current_raycast == "Sattelite" and Progress.current_objective == 2.5:
			Progress.sattelite_activated = true
			Progress.current_objective = Progress.current_objective + 0.5
		
		#Specific Sattelite Box code
		if Global.current_raycast == "Sattelite_Box":
			_add_item()
			Progress.current_objective = Progress.current_objective + 0.5
		
		#Specific Sphere cade
		if Global.current_raycast == "Bayonet":
			_add_item()

func _add_item():
	print("picked up " + Global.current_raycast)
	OnItemPickedUp.emit(Global.current_raycast)
	queue_free()
func emit_away():
	pass
=======
class_name InteractableItem

@export var ItemHighlightMesh : MeshInstance3D


func GainFocus():
	ItemHighlightMesh.visible = true
	
func LoseFocus():
	ItemHighlightMesh.visible = false
>>>>>>> Stashed changes
	
