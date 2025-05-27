extends Area3D
@export var item: InvItem
var obj_name = name
var player = null

func _process(delta):
	if Input.is_action_pressed("F") and Global.current_raycast == name:
		#player.collect(item)
		queue_free()
