extends NinePatchRect


onready var ob_name = $Name
onready var type = $Type
onready var desc = $Description 

func get_item_info(item:Item):
	ob_name.text = item.query("name")
	type.text = str(item.query("type"))
	desc.bbcode_text = item.query("long")
	
func connet_action(item:Item,actor):
	if item.has_method("do_eat"):
		var button = $HBoxContainer/ActionButton1
		button.text = "吃"
		button.connect("pressed",item,"do_eat",[actor])	

func _on_CloseButton_pressed():
	hide()
	pass # Replace with function body.
