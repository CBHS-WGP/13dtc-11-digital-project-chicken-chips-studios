extends Area3D

signal OnItemPickedUp(item)

@export var ItemTypes : Array[ItemData] = []

var NearbyAreas : Array[InteractableItem]

func _ready():
	OnItemPickedUp.emit(ItemTypes[1])
	print("Item id:" + str(1) + " Item Name:" + ItemTypes[1].ItemName)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("F")):
		PickupNearestItem()

func PickupNearestItem():
	var nearestItem : InteractableItem = null
	var nearestItemDistance : float = INF
	for item in NearbyAreas:
		if (item.global_position.distance_to(global_position) < nearestItemDistance):
			nearestItemDistance = item.global_position.distance_to(global_position)
			nearestItem = item
	
	if (nearestItem != null):
		nearestItem.queue_free()
		NearbyAreas.remove_at(NearbyAreas.find(nearestItem))
		var itemPrefab = nearestItem.scene_file_path
		for i in ItemTypes.size():
			if (ItemTypes[i].ItemModelPrefab != null and ItemTypes[i].ItemModelPrefab.resource_path == itemPrefab):
				print("Item id:" + str(i) + " Item Name:" + ItemTypes[i].ItemName)
				OnItemPickedUp.emit(ItemTypes[i])
				return
		
		printerr("Item not found")


func OnObjectEnteredArea(area: Area3D):
	if (area is InteractableItem):
		area.GainFocus()
		NearbyAreas.append(area)

func OnObjectExitedArea(area: Area3D):
	if (area is InteractableItem and NearbyAreas.has(area)):
		area.LoseFocus()
		NearbyAreas.remove_at(NearbyAreas.find(area))
