extends Control
#see note on "credit_quit.gd"
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
func _on_quit_pressed():
	get_tree().quit()
#Autoplay isnt working for some reason
func _process(delta):
	if $Win.playing == false:
		$Win.playing = true
