extends Control


func _ready():
	$"Settings animations".play("RESET")
	Global.settings_open = false
func _process(delta: float) -> void:
	#code which controls the ingame settings menu
	if Input.is_action_just_pressed("esc") and $"Settings animations".is_playing() == false and Global.settings_open == false:
		$"Settings animations".play("Open")
		Global.settings_open = true
	elif Input.is_action_just_pressed("esc") and $"Settings animations".is_playing() == false and Global.settings_open == true:
		$"Settings animations".play("Close")
		Global.settings_open = false
