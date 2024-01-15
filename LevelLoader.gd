extends Node

var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("/root/Game/Player/Camera2D")
	load_level("Levels/level_1.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Function to load a new level
func load_level(level_path: String):
	# Make sure the level exists
	if ResourceLoader.exists(level_path):
		var level_scene = load(level_path).instantiate()
		var level_root = get_node("/root/Game/LevelRoot")
		level_root.add_child(level_scene)
		set_camera_limits(level_scene)
	else:
		print("Level does not exist: " + level_path)

func clear_current_level(level_root: Node):
	for child in level_root.get_children():
		child.queue_free()

func set_camera_limits(level_instance: Node):
	var camera_bounds = level_instance.get_node("Map/CameraBounds")
	if camera_bounds:
		var rect = camera_bounds.shape.extents * 2 
		var global_position = camera_bounds.global_position

		camera.limit_left = global_position.x - rect.x / 2
		camera.limit_top = global_position.y - rect.y / 2
		camera.limit_right = global_position.x + rect.x / 2
		camera.limit_bottom = global_position.y + rect.y / 2
