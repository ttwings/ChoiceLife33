extends WindowCanDrag

# Called when the node enters the scene tree for the first time.

onready var item_icon = $VBoxContainer/ScrollContainer/HBoxContainer/VBoxContainer/CenterContainer/Icon

func _ready():
	load_res()
	pass # Replace with function body.

func load_res():
	if res and res is ResItem:
		title.text = res.name
		icon.texture = res.texture
		item_icon.texture = res.texture
		item_icon.rect_scale = Vector2(8,8)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
