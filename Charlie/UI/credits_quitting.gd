extends Control
#see note on "credit_quit.gd"
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _on_quit_pressed():
	get_tree().quit()
