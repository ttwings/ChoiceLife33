extends Node

onready var 持有者 = get_parent()
export(String,"家具","物品","书本","杂项") var 类型
export(Dictionary) var 属性
export(Array) var 拆解
export(Color) var 色彩

var 类别

func do_搬动():
	pass
	
func do_放置():
	pass
