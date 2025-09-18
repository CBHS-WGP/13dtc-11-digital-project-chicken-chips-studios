extends Control

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _on_quit_pressed() -> void:
	get_tree().quit()
