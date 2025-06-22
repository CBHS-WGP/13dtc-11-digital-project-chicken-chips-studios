extends Node3D

var hit = null
var ray
func _ready():
	ray = $Interacter

func _process(_delta: float) -> void:
	print(Progress.current_objective)
	if ray.is_colliding():
		hit = ray.get_collider()
		Global.current_raycast = hit.name
		print(hit.name)
	else:
		Global.current_raycast = null

	#These are all the code needed for interacting with specific objects.
	#For things like light switches, i need to consider moving this code to a script on the item
	#instead so the code works for just the instantiated object!
	if Input.is_action_pressed("F") and Global.current_raycast == "Sattelite" and Progress.current_objective == 1.5:
		if Global.equipped_item_id == str("Sattelite_Box"):
			Progress.current_objective = 1.99
	
	#ode to check finding the sattelite when the player has or hasnt already found the parts
	if Progress.current_objective == 0 and Global.current_raycast == "SatteliteFound" and Progress.Sattelite_Discovered == false:
		Progress.current_objective = 1
		Progress.Sattelite_Discovered = true
	#Extra statement incase the player has already foud the parts to repair the sattelite
	if Progress.current_objective == 0.5 and Global.current_raycast == "SatteliteFound" and Progress.Sattelite_Discovered == false:
		Progress.current_objective = 1.5
		Progress.Sattelite_Discovered = true
	if Progress.current_objective == 2.1 and Global.current_raycast == "Weapons_Cache_Found":
		Progress.current_objective = 2.5
