extends Node3D
func _ready():
	$MeshInstance3D2.visible = true

#Inefficient code that the weapons cache uses once reaching the objective, checking for the player
#to try opening the crate on objective 2.5, updating to 2.55, then running this script and setting it to 2.6.
#NOTE: Locating the weapons cache update to 2.5, the enemies spwawn in on 2.55, and the opening of the crate is 2.6.
func _process(_delta: float) -> void:
	if Progress.current_objective == 2.55:
		$Crate.play("open")
		$MeshInstance3D2.visible = false
		Progress.current_objective = 2.6
