extends Node3D

func _process(_delta: float) -> void:
	if Progress.current_objective == 2.1:
		pass


func _on_weapons_cache_found_body_entered(body: Node3D) -> void:
		if Progress.current_objective == 2.1 and body.is_in_group("player"):
			pass
