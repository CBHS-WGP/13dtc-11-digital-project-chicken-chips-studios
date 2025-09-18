extends Area3D

#Sets the node where the crater fog is for later
@onready var Crater = $"../Hiding crater"

#at the start ensure everything is set in place so the player cant acsess the crater yet
func _ready() -> void:
	$Pointer.visible = false
	$"../Hiding crater/Hiding crater".visible = true
	$"../Hiding crater/StaticBody3D/CollisionShape3D".disabled = false
	

func _process(delta: float) -> void:
	#this code stops the player from seeing and entering the crater early, allowing for smooth progression
	if Progress.current_objective > 2.6 and Crater.position.y > -20:
		$"../Hiding crater/StaticBody3D/CollisionShape3D".disabled = true
		$"../Hiding crater/Hiding crater".visible = false
		Crater.position += position.direction_to(Crater.position - Vector3(0, 20 , 0) * 0.25 * delta)
	#pointer shows on the correct objective, allowing the player to know what direction to start moving
	if Progress.current_objective == 3:
		$Pointer.visible = true
	else:
		$Pointer.visible = false
		
#indicates the player has found the crater for the first time after its been pointed to.
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and Progress.current_objective == 3:
		Progress.current_objective = 4
