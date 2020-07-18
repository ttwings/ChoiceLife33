extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func in_canvas_layer():
	print_debug("canvas")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_score(score):
	$Label.text = str(score)
