extends Control

class_name InventoryHandler 

@export var ItemSlotsCount : int = 4
@export var InventoryGrid : GridContainer
@export var InventorySlotPrefab : PackedScene = preload("res://Charlie/Inventory/Inv_Slot.tscn")

var InventorySlots : Array[InventorySlot] = []
#https://youtu.be/Ni2so5l_CVU?si=LL-t4veJCn2OwcOB
#Go from here 5:26
func _ready():
	Global.inv_open = false
	for i in ItemSlotsCount:
		var slot = InventorySlotPrefab.instantiate() as InventorySlot
		InventoryGrid.add_child(slot)
		slot.InventorySlotID = i
		InventorySlots.append(slot)
		
		
func PickupItem(item : ItemData):
	for slot in InventorySlots:
		if (!slot.SlotFilled):
			slot.FillSlot(item)
			break

func _process(_delta):
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
			
			
