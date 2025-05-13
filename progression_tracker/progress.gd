extends Node

var objective_1 = 0

func _process(delta):
	if Progress.objective_1 >= 5:
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		
