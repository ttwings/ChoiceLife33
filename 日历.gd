extends Node
# 以天为基本回合

#enum 季节{春,夏,秋,冬}

onready var 持有者 = get_parent()

signal 回合改变


const 回合每日 = 3
const 日每月 = 30
const 月每年 = 12


var 回合 := 0
#var 秒 := 0
#var 分 := 0
#var 时 := 0
var 日 := 0
var 月 := 0
#var 季 = 季节.春
var 年 := 0

func do_增长():
	回合 = 回合 + 1
	日 = 回合/回合每日%日每月
	月 = 回合/回合每日/日每月%月每年
	年 = 回合/回合每日/日每月/月每年
	
func get_日期():
	var 日期 = "%d 年 %d 月 %d 日 %d 回合" % [年+1,月+1,日+1,回合]
	return 日期
	
func on_回合改变():
	do_增长()
	if 持有者 is Label:
		持有者.text = get_日期()		
#
#func _process(delta: float) -> void:
#	on_回合改变()

func _ready():
	行为事件.connect("回合改变",self,"on_回合改变")
	if 持有者 is Label:
		持有者.text = get_日期()
