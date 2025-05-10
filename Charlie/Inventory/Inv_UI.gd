extends Control
#https://youtu.be/fyRcR6C5H2g?si=-8PLohTG6hwv2L17
#Part 2 to follow!!!
@onready var inv: Inv = preload("res://Charlie/Inventory/Player_Inventory.tres")
@onready var slots: Array = $Slots/NinePatchRect/GridContainer.get_children()

func _ready():
	update_slots()
	Global.inv_open = false
	
func _process(delta):
	if Input.is_action_just_pressed("tab") and $Open_Close.is_playing() == false:
		if Global.inv_open == false:
			Global.inv_open = true
			$Open_Close.play("open")
		else:
			Global.inv_open = false
			$Open_Close.play("close")
			

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
		
