extends Control
class_name InventoryHandler

@export var PlayerBody : CharacterBody3D
@export_flags_3d_physics var CollisionMask : int
#0, 1, 2 and 3 are inv, slot 4 is equipped slot (need the int to be five tho)
@export var ItemSlotsCount : int = 5

@export var InventoryGrid : GridContainer
@export var InventorySlotPrefab : PackedScene = preload("res://Charlie/Inventory/Inv_Slot.tscn")
@export var EquippingSlot : Control
@onready var camera = $"../../Camera/Camera"

var InventorySlots : Array[InventorySlot] = []


var EquippedSlot : int = -1

func _ready():
	#main inv slots
	for i in ItemSlotsCount - 1:
		var slot = InventorySlotPrefab.instantiate() as InventorySlot
		InventoryGrid.add_child(slot)
		slot.InventorySlotID = i
		slot.OnItemDropped.connect(ItemDroppedOnSlot.bind())
		slot.OnItemEquiped.connect(ItemEquipped.bind())
		InventorySlots.append(slot)
	#equippable slot
	var slot = InventorySlotPrefab.instantiate() as InventorySlot
	EquippingSlot.add_child(slot)
	slot.InventorySlotID = ItemSlotsCount - 1
	slot.OnItemDropped.connect(ItemDroppedOnSlot.bind())
	slot.OnItemEquiped.connect(ItemEquipped.bind())
	InventorySlots.append(slot)

func PickupItem(item : ItemData):
	var foundSlot : bool = false
	for slot in InventorySlots:
		if (!slot.SlotFilled):
			slot.FillSlot(item, false)
			foundSlot = true
			break
	
	if (!foundSlot):
		var newItem = item.ItemModelPrefab.instantiate() as Node3D
		
		PlayerBody.get_parent().add_child(newItem)
		newItem.global_position = PlayerBody.global_position + PlayerBody.global_transform.basis.x * 2.0

func ItemEquipped(slotID : int):
	if (EquippedSlot != -1):
		InventorySlots[EquippedSlot].FillSlot(InventorySlots[EquippedSlot].SlotData, false)
	
	if (slotID != EquippedSlot && InventorySlots[slotID].SlotData != null):
		InventorySlots[slotID].FillSlot(InventorySlots[slotID].SlotData, true)
		EquippedSlot = slotID
	else:
		EquippedSlot = -1

func ItemDroppedOnSlot(fromSlotID : int, toSlotID : int):
	if EquippedSlot != -1:
		if EquippedSlot == fromSlotID:
			EquippedSlot = toSlotID
		elif EquippedSlot == toSlotID:
			EquippedSlot = fromSlotID
	
	var toSlotItem = InventorySlots[toSlotID].SlotData
	var fromSlotItem = InventorySlots[fromSlotID].SlotData
	
	InventorySlots[toSlotID].FillSlot(fromSlotItem, EquippedSlot == toSlotID)
	InventorySlots[fromSlotID].FillSlot(toSlotItem, EquippedSlot == fromSlotID)
	


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data["Type"] == "Item"

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if (EquippedSlot == data["ID"]):
		EquippedSlot = -1
	
	var newItem = InventorySlots[data["ID"]].SlotData.ItemModelPrefab.instantiate() as Node3D
	InventorySlots[data["ID"]].FillSlot(null, false)
	
	PlayerBody.get_parent().add_child(newItem)
	newItem.global_position = GetWorldMousePosition()

func GetWorldMousePosition() -> Vector3:
	var mousePos = get_viewport().get_mouse_position()
	var cam = get_viewport().get_camera_3d()
	var ray_start = cam.project_ray_origin(mousePos)
	var ray_end = ray_start + cam.project_ray_normal(mousePos) * cam.global_position.distance_to(PlayerBody.global_position) * 2.0
	var world3d : World3D = PlayerBody.get_world_3d()
	var space_state = world3d.direct_space_state
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end, CollisionMask)
	
	var results = space_state.intersect_ray(query)
	if (results):
		Global.equipped_item_id = str("null")
		Global.item_update.emit()
		return results["position"] as Vector3 + Vector3(0.0, 0, 0.0)
	else:
		Global.equipped_item_id = str("null")
		Global.item_update.emit()
		return ray_start.lerp(ray_end, 0.5) + Vector3(0.0, 0.0, 0.0)
	
func _process(_delta):
	#Code that can olny be in this script, as i need to physically remove it
	#from the inventory before allowing the next objective to commence!
	if Progress.current_objective == 1.99:
		#Remove the sattelite cude from the current equipped slot!
		#Yes the way ive coded this is sloppy by using like 3 scripts... no i dont care
		InventorySlots[4].SlotData = null
		InventorySlots[4].IconSlot.texture = null
		Global.equipped_item_id = str("null")
		Global.item_update.emit()
		Progress.current_objective = 2
		
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
			
