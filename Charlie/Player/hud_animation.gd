extends Control

func _ready() -> void:
	$EndGame_Fade/Blac.self_modulate =  Color(0,0,0,0)
func _process(_delta: float) -> void:
	if Input.is_action_pressed("esc") and Global.settings_open == false and $"Settings animations".is_playing() == false:
		Global.settings_open = true
		$"Settings animations".play("Open")
	elif Input.is_action_pressed("esc") and Global.settings_open == true and $"Settings animations".is_playing() == false:
		Global.settings_open = false
		$"Settings animations".play("Close")
	#basic code that checks if the game is over, and plays a fade animation to set the player know the game is switching scenes
	if Progress.boss_killed == true and Progress.current_objective == 4:
		$EndGame_Fade/AnimationPlayer.play("end_fade")
		$EndGame_Fade/Timer.start()
		Progress.current_objective = 4.1


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Charlie/UI/Win screen.tscn")
