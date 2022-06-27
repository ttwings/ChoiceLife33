extends Node

enum race {
	人类,
	妖族,
	灵族,
	精怪,
	鬼族,
	魔族,
	动物,
	植物,
	矿石,
	流水,
	气体
}

const default_action_time = 5

var _SID = 0

func make_thing( path ):
	if $Things.has_node( path ):
		var obj = $Things.get_node(path).duplicate()
		obj.database_path = path
		obj.SID = _SID
		_SID += 1
		return obj

