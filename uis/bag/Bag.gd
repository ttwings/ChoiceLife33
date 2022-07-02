extends WindowCanDrag

export var title_name : String
onready var slot1 = $VBoxContainer/ScrollContainer/GridContainer/Slot1
onready var slot2 = $VBoxContainer/ScrollContainer/GridContainer/Slot2 
onready var container = $VBoxContainer
var item1
var item2
func _ready():
	title.text = title_name
	item1 = preload("res://data/items/weapons/Item.tscn").instance()
	item2 = preload("res://data/items/weapons/Item.tscn").instance()
	item1.res = load("res://data/items/weapons/axe_001.tres")
	item2.res = load("res://data/items/weapons/axe_002.tres")
	slot1.add_child(item1)
	slot2.add_child(item2)
	pass # Replace with function body.

