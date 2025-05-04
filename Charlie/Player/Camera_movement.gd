extends Node3D

const smoothness = 20
@onready var cam = $ "Camera"
var camera_input : Vector2
var rotation_velocity : Vector2

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		camera_input = event.relative
	
func _process(delta):
	if Global.inv_open == false:
		rotation_velocity = rotation_velocity.lerp(camera_input * Global.sensitivity, delta * smoothness)
		cam.rotate_x(camera_input.y/-57.29578 * Global.sensitivity)
		rotate_y(camera_input.x/-57.29578 * Global.sensitivity)
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -52, 80)
		camera_input = Vector2.ZERO
