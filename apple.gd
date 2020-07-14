extends Node2D

signal do_eat


func _init():
	set_meta("name","apple")
	set_meta("food",20)
	set_meta("water",{"food":10,"value":10})
	pass

func _ready():
	$Label.text = get_meta("name")
	pass

func _do_eat():
	emit_signal("do_eat",get_meta("food"))
	print_debug("do_eat",get_meta("food"))
	
func _do_drink():
	emit_signal("do_drink",get_meta("water"))

func _input(event):
	if event.is_action("mouse_left") :
		_do_eat()

func _on_Area2D_mouse_entered():
	$Label.show()
	pass


func _on_Area2D_mouse_exited():
	$Label.hide()
	pass
