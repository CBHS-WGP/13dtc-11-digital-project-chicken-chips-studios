extends Node
var current_objective = 1
# Objectinve 1 varibles
var objective_1 = 0

#Objective 2 varibles


func _process(delta):
	if Progress.objective_1 >= 5:
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		
