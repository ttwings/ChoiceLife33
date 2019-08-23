extends NinePatchRect


func get_item_info(item:Item):
	$Name.bbcode_text = item.query("name")
	$Type.bbcode_text = str(item.query("type"))
	$Description.bbcode_text = item.query("long")
	
func connet_action(item:Item,actor):
	if item.has_method("do_eat"):
		var button = $HBoxContainer/ActionButton1
		button.text = "吃"
		button.connect("pressed",item,"do_eat",[actor])	

func _on_CloseButton_pressed():
	hide()
	pass # Replace with function body.
