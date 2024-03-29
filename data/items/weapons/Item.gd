tool
extends Panel

export var res : Resource
onready var texture_rect = $VBoxContainer/TextureRect
onready var alias = $VBoxContainer/Label
onready var icon = texture_rect.texture

func load_res():
	if res and res is ResItem:
		alias.text = res.name
		texture_rect.texture = res.texture
		texture_rect.get("material").set_shader_param("outline_color",res.color)
		icon = texture_rect.texture
		self.mouse_filter = Control.MOUSE_FILTER_PASS
#
#
func _ready():
	load_res()
#
#func _init():
#	if res and res is ResItem:
#		alias.text = res.name
#		texture_rect.texture = res.texture
#		var color = res.color
#		var shader = texture_rect.get("material").set_shader_param("outline_color",color)
#		icon = texture_rect.texture
#		self.mouse_filter = Control.MOUSE_FILTER_PASS
