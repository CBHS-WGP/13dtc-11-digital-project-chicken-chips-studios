extends Node3D

var hit = null
var ray
func _ready():
	ray = $Interacter

func _process(delta: float) -> void:
	if ray.is_colliding():
		hit = ray.get_collider()
		Global.current_raycast = hit.name
	else:
		Global.current_raycast = null
	#print(Global.current_raycast)
	#print(Progress.current_objective)
	#These are all the code needed for interacting with specific objects.
	#For things like light switches, i need to consider moving this code to a script on the item
	#instead so the code works for just the instantiated object!
	if Input.is_action_pressed("F") and Global.current_raycast == "Sattelite" and Progress.current_objective == 2.5:
		if Progress.sattelite_box_collected == true:
			Progress.sattelite_box_collected = false
			Progress.current_objective = Progress.current_objective + 0.5
