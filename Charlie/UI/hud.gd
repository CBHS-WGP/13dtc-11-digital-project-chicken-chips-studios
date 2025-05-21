extends Control

func _process(delta):
	if Progress.current_objective == 1:
		$Main_Objective/Label.text = str("Kill 5 ememies:", Progress.objective_1, "/5")
	if Progress.current_objective == 2:
		$Main_Objective/Label.text = str("Locate the cube for the sattilite!")
	if Progress.current_objective == 3:
		$Main_Objective/Label.text = str("Find the sattilite and place the box inside!")
