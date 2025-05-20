extends Control
#https://youtu.be/fyRcR6C5H2g?si=-8PLohTG6hwv2L17
#Part 2 to follow!!!
@onready var inv: Inv = preload("res://Charlie/Inventory/Player_Inventory.tres")
@onready var slots: Array = $Slots/NinePatchRect/GridContainer.get_children()

func _ready():
	update_slots()
	Global.inv_open = false
	
func _process(delta):
	# Close and opens the inventory by clicking E (only when certain parapeters are met)
	if Input.is_action_just_pressed("E") and $Open_Close.is_playing() == false and Global.settings_open == false:
		if Global.inv_open == false:
			Global.inv_open = true
			$Open_Close.play("open")
		elif Global.settings_open == false and Input.is_action_just_pressed("E") and $Open_Close.is_playing() == false:
			Global.inv_open = false
			$Open_Close.play("close")
	#Additional code to ensure the inventory is closed whenever the setttings menu is open!
	if Input.is_action_just_pressed("esc") and Global.inv_open == true:
		Global.inv_open = false
		$Open_Close.play("close")
			


func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
		
