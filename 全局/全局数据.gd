extends Node

###	DATA SINGLETON	###
#	Stores all global/persistent game data


const VERSION = {
		"MAJOR":	0,
		"MINOR":	0,
		"BABY":		43
		}

enum 种族 {
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

const 默认行动时间 = 5

var _SID = 0

func 生成物体(节点地址):
	if $物体.has_node(节点地址):
		var 新物体 = $物体.get_node(节点地址).dublicate()
		新物体.数据地址 = 节点地址
		新物体.SID = _SID
		_SID += 1
		return 新物体

func make_thing( path ):
	if $Things.has_node( path ):
		var obj = $Things.get_node(path).duplicate()
		obj.database_path = path
		obj.SID = _SID
		_SID += 1
		return obj
