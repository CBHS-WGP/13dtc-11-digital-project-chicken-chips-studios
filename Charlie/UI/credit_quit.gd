extends Control
#for some reason i couldnt use the "credits_quitting" script for both
#the win and lose credits, so ive had to make 2.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _on_quit_2_button_down() -> void:
	get_tree().quit()
