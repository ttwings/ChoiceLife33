extends Node


enum 季节{春,夏,秋,冬}

var 回合 := 0
var 秒 := 0
var 分 := 0
var 时 := 0
var 天 := 0
var 月 := 0
var 季 = 季节.春
var 年 := 0

func do_增长():
	回合 = 回合 + 1


func _ready():
	pass
