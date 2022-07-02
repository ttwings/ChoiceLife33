extends Panel

class_name PanelCanDrag

var _reset_position = Vector2()
var _previous_mouse_position = Vector2()
var _is_dragging = false

signal on_open
signal on_closed

func _ready():
	_reset_position = rect_position

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

func _on_TextureButton_pressed():
	hide()
