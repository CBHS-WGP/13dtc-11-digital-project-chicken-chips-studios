extends Control

func _process(delta):
	$Main_Objective/Label.text = str("Kill 5 ememies:", Progress.objective_1, "/5")
