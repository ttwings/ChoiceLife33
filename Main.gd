extends Control

export var log_rect_size : Vector2 = Vector2(300,400)
export var log_rect_pos : Vector2 = Vector2(1400,9)
export var bag_panel_rect_size : Vector2 = Vector2(300,400)
export var bag_panel_rect_pos : Vector2 = Vector2(400,400)


onready var status = $VBoxContainer/PanelStatus/HBoxContainer
onready var log_panel = $VBoxContainer/PanelContainer/Log
onready var bag_panel = $VBoxContainer/PanelContainer/Bag

func panel_rect_set():
	log_panel.rect_position = log_rect_pos
	log_panel.rect_size = log_rect_size
	bag_panel.rect_position = bag_panel_rect_pos
	bag_panel.rect_size = bag_panel_rect_size

# Called when the node enters the scene tree for the first time.
func _ready():
#	panel_rect_set()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_WindowCanDrag_on_mini(obj:WindowCanDrag):
#	print_debug(obj)
#	var button = Button.new()
#	button.rect_size = Vector2(90,30)
#	button.text = obj.title.text
#	button.connect("pressed",obj,"show")
#	status.add_child(button)
#	pass # Replace with function body.
