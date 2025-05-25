extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/Item

func update(slot: InvSlot):
	if not slot.item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
