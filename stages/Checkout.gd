extends Control

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var time_out = false
var db_dishes = []
var dishes = []
var current_dish
var point = 10
var level = 1
var nick_name = "门外汉"
#var stage_main = preload("res://stages/Main.tscn")
func update_nick_name(level:int):
	match level:
		1:return "门外汉"
		2:return "账房学徒"
		3:return "账房见习"
		4:return "账房新手"
		5:return "账房先生"
		6:return "账房老师"
		7:return "账房大师"
		8:return "铁算盘"
		9:return "神算子"
		_:return "算圣"


func random_dishes():
	for i in range(level):
		dishes.append()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	db_dishes = Global.load_data("res://data/dishes.json").duplicate()
	current_dish = db_dishes[randi()%db_dishes.size()]
	pick_dish()
	pass # Replace with function body.

func pick_dish():
	level = point / 10 if point/10 >0 else 1
	$Panel/Nickname.text = update_nick_name(level)
	dishes.clear()
	db_dishes.shuffle()
	$Panel/Bill.bbcode_text = "账单：\n"
	for i in range(level):
		dishes.append(db_dishes[i])
		$Panel/Bill.bbcode_text += db_dishes[i].name + ":" + str(db_dishes[i].value) + "\n"
		
	print_debug(sum_value()," vs ",sum_digit())	
#	
#	current_dish = db_dishes.front()
#	$Panel/Bill.bbcode_text += current_dish.name + ":" + str(current_dish.value) + "\n"


func _on_Timeleft_time_out() -> void:
	$TimeOver.dialog_text = "时间到了你现在的水平为" + nick_name
	match level:
		1,2:$TimeOver.dialog_text += "\n 再回去练练,老板并不想雇你"
		3,4:$TimeOver.dialog_text += "\n 老板打算试用看看,工钱每月" + str(level * 100) + "钱"
		5,6:$TimeOver.dialog_text += "\n 老板打算雇佣你,工钱每月" + str(level * 200) + "钱"
		7,8:$TimeOver.dialog_text += "\n 你高超的技艺震慑住了老板,有点不好意思的开出了雇佣价钱每月" + str(level * 400) + "钱"
		9:$TimeOver.dialog_text += "\n 老板已经不会说话"
		_:$TimeOver.dialog_text += "\n 周围的空气仿佛已经凝固"
	$TimeOver.show()
	$TimeOver.connect("confirmed",get_tree(),"quit")
	pass # Replace with function body.



func _on_Check_pressed() -> void:
#	print_debug(check_value(current_dish.value,sum_digit()).long)
	$Panel/Sumdigit.text = "计算总价：" + str(sum_digit())
	$Panel/Sumvalue.text = "货品总价：" + str(sum_value())
	
	var msg = check_value(sum_value(),sum_digit())
	$Panel/Response.bbcode_text = msg.long
	point = point + msg.point
	if point <= 0 :
		$GameOver.show()
	$Panel/Point.text = "评分：" + str(point)
	print_debug("point",point)
	pick_dish()
	$Panel/Timeleft.value = $Panel/Timeleft.max_value
	pass # Replace with function body.

# 多道菜算账

func sum_value():
	var value = 0
	if dishes.size() == 0 :
		return 0
	for f in dishes:
		value = value + f.value
	return value
	pass
	
func sum_digit():
	var sum = 0
	sum += $Suanpan/digit1.get_sum()
	sum += $Suanpan/digit2.get_sum()
	sum += $Suanpan/digit3.get_sum()
	sum += $Suanpan/digit4.get_sum()
	sum += $Suanpan/digit5.get_sum()
	sum += $Suanpan/digit6.get_sum()
	sum += $Suanpan/digit7.get_sum()
	sum += $Suanpan/digit8.get_sum()
	sum += $Suanpan/digit9.get_sum()
	sum += $Suanpan/digit10.get_sum()
	sum += $Suanpan/digit11.get_sum()
	sum += $Suanpan/digit12.get_sum()
	sum += $Suanpan/digit13.get_sum()
	print_debug(sum)
	return sum

func check_value(value:int,number:int):
	var rank1 = {"rank":100 ,"long":"算的漂亮，顾客和老板都满意","point": 2}
	var rank2 = {"rank":80 ,"long":"打了点折扣，顾客很满意，老板会心一笑","point": 4}
	var rank3 = {"rank":70 ,"long":"折扣稍微有点大，顾客有点惊喜，老板强颜欢笑","point": 0}
	var rank4 = {"rank":60 ,"long":"折扣有点大了，顾客窃喜，老板脸色不好看","point": -1}
	var rank5 = {"rank":50 ,"long":"有点算多了，顾客不满意！","point": -2}
	var rank6 = {"rank":40 ,"long":"算太多了，顾客很生气，大发雷霆，引来围观，老板赶快赔不是！","point": -4}
	var rank7 = {"rank":30 ,"long":"这算的什么账，闪开","point": -6}
	var rank_end = {"rank":30,"long":"时间已经到了，你还没算出来，老板亲自来算","point":-5}
	
	if number >= value * 1.5 :
		return rank6
	if number >= value * 1.1 and number < value * 1.5:
		return rank5	
	if number >= value and number < value * 1.1:
		return rank1
	if number >= value * 0.9 and number < value:
		return rank2
	if number >= value * 0.8 and number < value * 0.9:
		return rank3
	if number >= value * 0.7 and number < value * 0.8:
		return rank4
	
	
	return rank7		
	pass	

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://stages/Main.tscn")
#	get_tree().change_scene_to(stage_main)
	pass # Replace with function body.
