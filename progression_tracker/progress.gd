extends Node
var current_objective = 1
# Objectinve 1 varibles
var objective_1 = 0

var sattelite_activated = false

#Objective 2 varibles


func _process(_delta):
	#Progressing past objective 1
	if Progress.objective_1 >= 5:
		current_objective = current_objective + 1
		objective_1 = 0
	#Progressing past objective 2
	if Progress.sattelite_activated == true:
		pass
	#If objective 3, win the game
	if Progress.current_objective == 3:
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		
	#Player death
	if Global.health <= 0:
		print("dead")
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		
