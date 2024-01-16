extends Node2D
var player : CharacterBody2D
var mousePos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		mousePos = to_local(event.position)
		queue_redraw()

func _draw():
	draw_line(to_local(player.position), mousePos * 100, Color.WHITE)
	print(mousePos, player.position)
