extends CPUParticles3D
#Gun explosion effect
func _ready():
	emitting = true

func _process(_delta):
	if emitting == false:
		queue_free()
