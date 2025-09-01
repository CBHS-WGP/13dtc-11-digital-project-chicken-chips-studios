extends Area3D
@onready var Crater = $"../Hiding crater"
func _ready() -> void:
	$Pointer.visible = false
	$"../Hiding crater/Hiding crater".visible = true
	$"../Hiding crater/StaticBody3D/CollisionShape3D".disabled = false
	

func _process(delta: float) -> void:
	if Progress.current_objective > 2.6 and Crater.position.y > -20:
		$"../Hiding crater/StaticBody3D/CollisionShape3D".disabled = true
		$"../Hiding crater/Hiding crater".visible = false
		Crater.position += position.direction_to(Crater.position - Vector3(0, 20 , 0) * 0.25 * delta)
	if Progress.current_objective == 3:
		$Pointer.visible = true
	else:
		$Pointer.visible = false
		

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and Progress.current_objective == 3:
		Progress.current_objective = 4
