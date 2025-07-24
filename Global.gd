extends Node

signal shot

var inv_open = false
var sensitivity = 0.15
var resolution = Vector2(1280, 720)
var current_areas = 0
var crouching = false
var health = 100
var settings_open = false
var current_raycast 
var equipped_item_id = str("null")
var G32_bullets = 0
var P90_bullets = 100
var P90_bullets_in_mag = 50
var pistol_bullets = 12
var flashlight_out = true
func dead(_delta):
	if health == 0:
		get_tree().quit()
