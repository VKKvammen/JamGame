extends RayCast2D
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		target_position = to_local(event.position) * 100
		queue_redraw()

func _draw():
	draw_line(to_local(player.position), to_local(get_collision_point()), Color.WHITE)

