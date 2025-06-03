extends Node

signal shot

var inv_open = false
var sensitivity = 0.15
var resolution = Vector2(1280, 720)
var crouching = false
var health = 100
var settings_open = false
<<<<<<< Updated upstream
var current_raycast
var ray_global
=======
>>>>>>> Stashed changes

func dead(_delta):
	if health == 0:
		get_tree().quit()
