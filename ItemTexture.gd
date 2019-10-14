extends TextureRect

func _ready():
	pass

func _on_ItemTexture_mouse_entered() -> void:
	$ItemPanel.show()
	pass # Replace with function body.


func _on_ItemPanel_mouse_exited() -> void:
	$ItemPanel.hide()
	pass # Replace with function body.
