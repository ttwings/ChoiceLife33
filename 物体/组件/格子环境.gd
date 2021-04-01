extends Node

onready var 瓦片地图:TileMap = get_parent().get_node("地图")

func _ready() -> void:
	print(瓦片地图.name)
	pass
#	is_拥有瓦片地图()
		
func is_拥有瓦片地图():
	if 瓦片地图 and 瓦片地图 is TileMap :
		return
	else :
		printerr("需要 父类 为TiledMap")
			
func _input(event: InputEvent) -> void:
	if event.is_action("mouse_left"):
		var mouse = 瓦片地图.get_global_mouse_position()
		print(mouse)
		print(瓦片地图.world_to_map(mouse))
