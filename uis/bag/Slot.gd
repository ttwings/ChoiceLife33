extends PanelContainer

func get_drag_data(position):
	if has_node("Item"):
		print_debug($Item)
		var texture_rect = TextureRect.new()
		texture_rect.texture = get_node("Item").icon
		texture_rect.rect_scale = Vector2(4,4)
		set_drag_preview(texture_rect)
		return get_node("Item")
	return false
	
func can_drop_data(position, data):
	return true
	
func drop_data(position, data):
	var new_data
	if data and !has_node("Item"):
		self.add_child(data.duplicate())
		data.queue_free()
		
