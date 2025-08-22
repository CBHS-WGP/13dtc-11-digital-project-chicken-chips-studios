extends Control




#dictionary of all allowed resolutions (can be easily expanded in the future)
var dictionaryContainer = {
	0: Vector2(1280, 720),
	1: Vector2(1920, 1080),
	2: Vector2(1842, 1036),
	3: Vector2(256, 144)
	}



func _on_check_box_toggled(toggled_on):
		if toggled_on == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			get_window().size = Global.resolution


func _on_window_sizes_item_selected(index):
	#Sets the default resolution to the option selected by getting the corresponding resolution in the dictionary.
	Global.resolution = dictionaryContainer[index]
	get_window().size = Global.resolution
	#size = Global.resolution
	
	#Extremely convoluted way of selecting a window size 
	#THIS IS OLD CODE I COULD USE AS PART OF THE PROGRAMMING STANDARD!
	#if $Options/Options_Box/Window_Sizes.selected == 2:
		#Global.resolution = Vector2(1280, 720)
		#get_window().size = Global.resolution
	#elif $Options/Options_Box/Window_Sizes.selected == 0:
		#Global.resolution = Vector2(1920, 1080)
		#get_window().size = Global.resolution
	#elif $Options/Options_Box/Window_Sizes.selected == 1:
		#Global.resolution = Vector2(1842, 1036)
		#get_window().size = Global.resolution
	#elif $Options/Options_Box/Window_Sizes.selected == 3:
		#Global.resolution = Vector2(256, 144)
		#get_window().size = Global.resolution
