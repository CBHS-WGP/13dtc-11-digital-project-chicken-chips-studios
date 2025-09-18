extends RigidBody3D

class_name InteractableItem
#Allows for setting the mesh that glows when the player interactor is colliding
#Used on all items.
@export var ItemHighlightMesh : MeshInstance3D

#Functions that turn off and on the set mesh (the light blue one around items).
func GainFocus():
	ItemHighlightMesh.visible = true

func LoseFocus():
	ItemHighlightMesh.visible = false
