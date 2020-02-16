extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal do_eat


func _init():
	set_meta("name","apple")
	set_meta("food",20)
	set_meta("water",{"food":10,"value":10})
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = get_meta("name")
	pass # Replace with function body.

func _do_eat():
	emit_signal("do_eat",get_meta("food"))
	print_debug("do_eat",get_meta("food"))
	
func _do_drink():
	emit_signal("do_drink",get_meta("water"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action("mouse_left") :
		_do_eat()

func _on_Area2D_mouse_entered():
	$Label.show()
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	$Label.hide()
	pass # Replace with function body.
