extends Area3D

signal OnItemPickedUp(item)

@export var ItemTypes : Array[ItemData] = []

var NearbyAreas : Array[InteractableItem]
var sattelite_box_collected = false


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
		#I nee to set the pistol magazine name thing to work properly!!
		#fix
		#fix
	if (nearestItem != null) and nearestItem.name != "Pistol_Magazine":
		nearestItem.queue_free()
		NearbyAreas.remove_at(NearbyAreas.find(nearestItem))
		var itemPrefab = nearestItem.scene_file_path
		for i in ItemTypes.size():
			if (ItemTypes[i].ItemModelPrefab != null and ItemTypes[i].ItemModelPrefab.resource_path == itemPrefab):
				print("Item id:" + str(i) + " Item Name:" + ItemTypes[i].ItemName)
				if i != 4:
					OnItemPickedUp.emit(ItemTypes[i])
				
				#One time use script for when the player picks up the sattelite box
				if i == 0 and sattelite_box_collected == false:
					sattelite_box_collected = true
					print("SATTELLITE BOX COLLECTED")
					if Progress.current_objective == 0:
						Progress.current_objective = 0.5
					if Progress.current_objective == 1:
						Progress.current_objective = 1.5
				elif i == 4:
					nearestItem.queue_free()
					Global.G32_bullets = Global.G32_bullets + 12
				return
	printerr("Item not found")


func OnObjectEnteredBody(body: Node3D):
	if (body is InteractableItem):
		body.GainFocus()
		NearbyAreas.append(body)

func OnObjectExitedBody(body: Node3D):
	if (body is InteractableItem and NearbyAreas.has(body)):
		body.LoseFocus()
		NearbyAreas.remove_at(NearbyAreas.find(body))
