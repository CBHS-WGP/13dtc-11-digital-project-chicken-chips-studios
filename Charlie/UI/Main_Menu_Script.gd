extends Control

func _ready():
	#Sets the resolution to the default when starting up the game.
	get_window().size = Global.resolution
	size = Global.resolution
	$AnimationPlayer.play("Startup_Animation")


#Quits the game
func _on_exit_pressed():
	get_tree().quit()
	
#begins the game
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Charlie/Maps/Test_Map.tscn")

func _on_options_pressed():
	$AnimationPlayer.play("Options_Open")

func _on_back_pressed():
	$AnimationPlayer.play("Options_Close")
