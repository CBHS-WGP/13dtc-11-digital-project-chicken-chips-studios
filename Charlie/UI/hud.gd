extends Control
var damage_taken


func _process(_delta):
	print(Progress.current_objective)
	if Progress.current_objective == 0 or Progress.current_objective == 0.5:
		$Main_Objective/Label.text = str("Locate the sattellite for inspection")
	elif Progress.current_objective == 1:
		$Main_Objective/Label.text = str("Locate the cube for the sattilite!")
	elif Progress.current_objective == 1.5:
		$Main_Objective/Label.text = str("Use the parts to repair the sattelite")
	elif Progress.current_objective == 2.1:
		$Main_Objective/Label.text = str("Find the weapons cache")
	elif Progress.current_objective == 2.6:
		$Main_Objective/Label.text = str("Kill all 10 enemies!")
		$Main_Objective/Sub_Objective.visible = true
		$Main_Objective/Sub_Objective.text = str("Killed:", Progress.obj_2_enemies_killed, "/10")
	elif Progress.current_objective == 3:
		$Main_Objective/Sub_Objective.visible = false
		$Main_Objective.text = str("Make the impact site")
	else:
		$Main_Objective/Label.text = str("TBC")

		
	#Code to update the health HUD visual
	$Heatlh_Visualizer/Heart_Beating.play("Fast_pulse")
	damage_taken = (100 - Global.health) * 2.25
	$Heatlh_Visualizer/Health.text = str("Health:", Global.health, "/100")
	
	$Heatlh_Visualizer/Red_Hue.modulate = Color8(255, 255, 255, damage_taken/2.5)
	if damage_taken <= 112:
		$"Heatlh_Visualizer/Damage 1".modulate =  Color8(255, 255, 255, damage_taken * 2)
	
	if 112 < damage_taken and damage_taken <= 225:
		$Heatlh_Visualizer/Critital.modulate = Color8(255, 255, 255, (damage_taken - 112) * 2)
	else:
		$Heatlh_Visualizer/Critital.modulate = Color8(255, 255, 255, 0)
		
	
