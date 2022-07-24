extends WindowCanDrag

# Called when the node enters the scene tree for the first time.

onready var item_icon = $"%Icon"
onready var alias = $"%Name"
onready var type = $"%Type"
onready var attack = $"%Attack"
onready var defence = $"%Defence"
onready var special = $"%Special"
onready var weight = $"%Weight"
onready var location = $"%Location"

func _ready():
	load_res()
	pass # Replace with function body.

func load_res():
	if res and res is ResItem:
		title.text = res.name
		title.set("custom_colors/font_color",res.color)
		alias.get_node("Value").text = res.name
		alias.get_node("Value").set("custom_colors/font_color",res.color)
		type.get_node("Value").text = res.type
		icon.texture = res.texture
#		icon.get("material").set_shader_param("outline_color",res.color)
		item_icon.texture = res.texture
		item_icon.rect_scale = Vector2(8,8)
		item_icon.get("material").set_shader_param("outline_color",res.color)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
