extends Control

onready var status = $VBoxContainer/PanelStatus/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WindowCanDrag_on_mini(obj:WindowCanDrag):
	print_debug(obj)
	var button = Button.new()
	button.rect_size = Vector2(90,30)
	button.text = obj.title.text
	button.connect("pressed",obj,"show")
	status.add_child(button)
	pass # Replace with function body.
