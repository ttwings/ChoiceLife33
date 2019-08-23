extends Char
class_name User

func userp(ob):
	return true
	
func load_data(path):
	set_dbase(gdutils.utils.json.load_json(path))
	
	