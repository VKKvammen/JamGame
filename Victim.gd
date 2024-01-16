extends Area2D


var logged = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlap = get_overlapping_areas()
	if overlap:
		print(overlap)
	pass
