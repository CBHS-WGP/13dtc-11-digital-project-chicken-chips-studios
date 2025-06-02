extends Node3D

signal OnItemPickedUp(item)
var hit = null
@export var ItemTypes : Array[ItemData] = []

func _process(delta: float) -> void:
	var ray = $Pickup
	if ray.is_colliding():
		hit = ray.get_collider()
		#print(hit)
		#print(hit.name)
		Global.current_raycast = hit.name
	else:
		Global.current_raycast = null
	if Global.current_areas != null:
		var itemPrefab = ray.scene_file_path
		for i in ItemTypes.size():
			if (ItemTypes[i].ItemModelPrefab != null and ItemTypes[i].ItemModelPrefab.resource_path == itemPrefab):
				print("Item ID:" + str(i) + "Item Name" + ItemTypes[i].ItemName)
				OnItemPickedUp.emit(ItemTypes[i])
				return
			print("na")
