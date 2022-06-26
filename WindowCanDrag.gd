extends Panel

class_name WindowCanDrag

var _reset_position = Vector2()
var _previous_mouse_position = Vector2()
var _is_dragging = false

onready var size = Vector2(400,400)
onready var icon = $VBoxContainer/PanelTitle/HBoxContainer/Icon
onready var title = $VBoxContainer/PanelTitle/HBoxContainer/Title
onready var panel = $VBoxContainer/ScrollContainer/Panel
onready var status = $VBoxContainer/PanelStatus/HBoxContainer/Status

signal on_open
signal on_closed
signal on_mini

func _ready():
	_reset_position = rect_position
	rect_size = size

func _process(delta):
	if _is_dragging:
		var mouse_delta = _previous_mouse_position - get_local_mouse_position()
		rect_position -= mouse_delta

func _gui_input(event):
	if event.is_action_pressed("ui_select"):
		_is_dragging = true
		_previous_mouse_position = get_local_mouse_position()
	if event.is_action_released("ui_select"):
		_is_dragging = false

func show():
	emit_signal("on_open")
	rect_position = _reset_position
	visible = true

func hide():
	emit_signal("on_closed")
	visible = false

func mini():
	emit_signal("on_mini",self)
	visible = false

func _on_ButtonMini_pressed():
	mini()
	pass # Replace with function body.


func _on_ButtonClose_pressed():
	hide()
	pass # Replace with function body.
