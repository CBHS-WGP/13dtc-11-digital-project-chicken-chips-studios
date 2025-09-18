extends Control
var damage_taken

func _process(_delta):
	#Each box has a seperate objective text inside, very inefficient and could have used
	#a dictionary, but this does the job, and is early code
	if Progress.current_objective == 0 or Progress.current_objective == 0.5:
		$Main_Objective.text = str("Locate the sattellite for inspection")
	elif Progress.current_objective == 1:
		$Main_Objective.text = str("Locate the cube for the sattilite!")
	elif Progress.current_objective == 1.5:
		$Main_Objective.text = str("Use the parts to repair the sattelite")
	elif Progress.current_objective == 2.1:
		$Main_Objective.text = str("Find the weapons cache")
	elif Progress.current_objective == 2.6:
		$Main_Objective.text = str("Kill all the enemies!")
		$Sub_Objective.visible = true
		$Objective_Control/UI_Control/Back_Bottom_UI.visible = true
		$Sub_Objective.text = str("Killed:", Progress.obj_2_enemies_killed, "/", Progress.spawn_enemies_obj_2)
	elif Progress.current_objective == 3:
		$Sub_Objective.visible = false
		$Objective_Control/UI_Control/Back_Bottom_UI.visible = false
		$Main_Objective.text = str("Find the impact site!")
	elif Progress.current_objective == 4:
		$Main_Objective.text = str("Enter the crater to end this all!")
	#Backup incase a differnet value appears so the game has no chance of crashing from this process.
	else:
		$Objective_Control/UI_Control/Back_Bottom_UI.visible = false
		$Sub_Objective.visible = false
		$Main_Objective.text = str("")

	if Global.health < 100:
		Global.health = Global.health + 0.02
	#Code to update the health HUD visual
	#This updates 3 seperate layers which indicate damage taken based on opacity (0 to 255).
	$Heatlh_Visualizer/Heart_Beating.play("Fast_pulse")
	damage_taken = (100 - Global.health) * 2.25
	$Heatlh_Visualizer/Health.text = str("Health:", "%.0f" % Global.health, "/100")
	
	$Heatlh_Visualizer/Red_Hue.modulate = Color8(255, 255, 255, damage_taken/2.5)
	if damage_taken <= 112:
		$"Heatlh_Visualizer/Damage 1".modulate =  Color8(255, 255, 255, damage_taken * 2)
	
	if 112 < damage_taken and damage_taken <= 225:
		$Heatlh_Visualizer/Critital.modulate = Color8(255, 255, 255, (damage_taken - 112) * 2)
	else:
		$Heatlh_Visualizer/Critital.modulate = Color8(255, 255, 255, 0)
	#Code for the bullets UI to show the player their ammo for respective weapons when holding, otherwise hide the bullet UI.
	if Global.equipped_item_id == str("G32 Pistol"):
		$G32_Bullets.visible = true
		$Bullets_Back_Image.visible = true
		$P90_Bullets.visible = false
		$G32_Bullets.text = str("Bullets ", Global.G32_bullets_in_mag, "/", Global.G32_bullets)
	elif Global.equipped_item_id == str("P90"):
		$G32_Bullets.visible = false
		$Bullets_Back_Image.visible = true
		$P90_Bullets.visible = true
		$P90_Bullets.text = str("Bullets ", Global.P90_bullets_in_mag, "/", Global.P90_bullets)
	else:
		$G32_Bullets.visible = false
		$P90_Bullets.visible = false
		$Bullets_Back_Image.visible = false
