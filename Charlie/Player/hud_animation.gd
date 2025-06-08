extends Control

func _process(_delta: float) -> void:
	if Input.is_action_pressed("esc") and Global.settings_open == false and $"Settings animations".is_playing() == false:
		Global.settings_open = true
		$"Settings animations".play("Open")
	elif Input.is_action_pressed("esc") and Global.settings_open == true and $"Settings animations".is_playing() == false:
		Global.settings_open = false
		$"Settings animations".play("Close")
