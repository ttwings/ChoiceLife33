extends Resource

class_name ResourceTrees


func _get_texture(name:String):
	if get_chiled.has(name):
		return get_chiled(name).texure
