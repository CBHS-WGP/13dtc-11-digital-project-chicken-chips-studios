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
func dead(_delta):
	if health == 0:
		get_tree().quit()
