extends Node3D
func _ready():
	$MeshInstance3D2.visible = true

func _process(_delta: float) -> void:
	#print(Progress.current_objective)
	if Progress.current_objective == 2.55:
		$Crate.play("open")
		$MeshInstance3D2.visible = false
		Progress.current_objective = 2.6


#func _on_weapons_cache_found_body_entered(body: Node3D) -> void:
		#if Progress.current_objective == 2.55 and body.is_in_group("player"):
			#Progress.current_objective == 2.6
