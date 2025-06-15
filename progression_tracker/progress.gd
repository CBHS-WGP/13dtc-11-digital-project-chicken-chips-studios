extends Node
var current_objective = 1
# Objectinve 1 varibles
var objective_1 = 0



func _process(_delta):
	#Progressing past objective 1 (killing 5 enemies)
	if Progress.objective_1 >= 5:
		current_objective = current_objective + 1
		objective_1 = 0
	if Progress.current_objective == 1:
		pass
	#If objective 3, win the game
	if Progress.current_objective == 3:
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		
	#Player death
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		
