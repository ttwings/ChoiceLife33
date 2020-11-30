extends Thing

var spriteDB = preload("res://assets/graphics/tiles/TileOutside.tscn")

export var db_tree : Resource = null
onready var sprite = get_node("Sprite")
var db
func _ready() -> void:
	db = spriteDB.instance()
#	$Sprite.texture = db.get_node("船").texture
#	$Sprite.region_rect = db.get_node("船").region_rect
#	$Sprite.region_enabled = db.get_node("船").region_enabled
#	$Sprite = db.get_node()
	sprite.texture = db_tree.tile_name("船")
	
	print_debug($Sprite.get_property_list())
	pass


func _setup_sprite(db:PackedScene,t_name:String):
	var _db = db.instance()
	sprite.texture = _db.get_node("船").texture
	
