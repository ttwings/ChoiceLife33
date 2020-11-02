extends Node2D

var id = 'bed_001' 
var type = 'furniture'
var name_cn = "床"
var weight
var ob_material
var value
var size = Vector2(32,64)

var data = {
	'id' : "wood bed",
	'type' : 'furniture',
	'name_cn' : "木床",
	'weight' : 2000,
	'ob_material' : "wood",
	'value' : 100
}
func _ready():
	load_data(data)
	print(self.id,self.type,self.name_cn,self.weight,self.ob_material,self.value)

func load_data(data:Dictionary):
	for key in data:
		set(key,data[key])
