extends Node

onready var 持有者 = get_parent()

export(int,-100,100) var 美观度 = 0
export(int,-100,100) var 灵气 = 0 
export(int,0,100) var 金 = 0
export(int,0,100) var 水 = 0
export(int,0,100) var 木 = 0
export(int,0,100) var 火 = 0
export(int,0,100) var 土 = 0
export(String) var 材质 = "灵木" 

var 类别

func do_搬动():
	pass
	
func do_放置():
	pass
