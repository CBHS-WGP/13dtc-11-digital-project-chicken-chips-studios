extends Control

class_name InventoryHandler 

@export var PlayerBody : CharacterBody3D
@export_flags_3d_physics var CollisionMask : int

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
		slot.OnItemDropped.connect(ItemDroppedOnSlot.bind())
		InventorySlots.append(slot)

func ItemDroppedOnSlot(fromSlotID : int, toSlotID : int):
	var toSlotItem = InventorySlots[toSlotID].SlotData
	var fromSlotItem = InventorySlots[fromSlotID].SlotData
	
	InventorySlots[toSlotID].FillSlot(fromSlotItem)
	InventorySlots[fromSlotID].FillSlot(toSlotItem)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data["TYPE"] == "Item"
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var newItem = InventorySlots[data["ID"]].SlotData.ItemModelPrefab.instantiate() as Node3D
	InventorySlots[data["ID"]].FillSlot(null)
	
	PlayerBody.get_parent().add_child(newItem)
	newItem.global_position = GetWorldMousePosition()
	
func GetWorldMousePosition() -> Vector3:
	var mousePos = get_viewport().get_mouse_position()
	var cam = get_viewport().get_camera_3d()
	var ray_start = cam.project_ray_origin(mousePos)
	var ray_end = ray_start + cam.project_ray_normal(mousePos) * cam.global_position.distance_to(PlayerBody.global)
	var world3d : World3D = PlayerBody.get_world_3d()
	var space_state = world3d.direct_space_state
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end, CollisionMask)
	
	var results = space_state.intersect_ray(query)
	if (results):
		return results["position"] as Vector3 + Vector3(0.0, 0.5, 0.0)
	else:
		return ray_start.lerp(ray_end, 0.5) + Vector3(0.0, 0.5, 0.0)



func PickupItem(item : ItemData):
	for slot in InventorySlots:
		if (!slot.SlotFilled):
			slot.FillSlot(item)
			break
	if item.ItemName == "Sattelite_Box":
		Progress.sattelite_box_collected = true
		Progress.current_objective = Progress.current_objective + 0.5

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
			
			
