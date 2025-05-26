extends Area3D
@export var item: InvItem

func _process(delta):
	if Input.is_action_pressed("F") and Global.current_raycast == "Sattelite_Box":
		queue_free()
