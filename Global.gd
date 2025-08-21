extends Node
#fired when the player needs to take damage
signal shot
#fired when the player presses F on an available object in 3D space.
signal item_update

var inv_open = false
var sensitivity = 0.15
var resolution = Vector2(1280, 720)
var current_areas = 0
var crouching = false
var health = 100
var settings_open = false
var current_raycast 
var equipped_item_id = str("null")
var G32_bullets = 12
var G32_bullets_in_mag = 12
var P90_bullets = 100
var P90_bullets_in_mag = 50
var pistol_bullets = 12
var flashlight_out = true
func dead(_delta):
	if health == 0:
		get_tree().quit()
