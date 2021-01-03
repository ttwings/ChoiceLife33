extends Control

const recipes = {
# 佐料	
	"咸鲜":1,
	"酸爽":2,
	"甘甜":4,
	"辛辣":8,
	"苦涩":16,

# 火候
	"煮涮":32,
	"蒸焖":64,
	"烙烤":128,
	"炖熬":256,
	"炸炒":512,
# 材料	
	"谷面":1024,
	"果蔬":2048,
	"蛋奶":4096,
	"肉禽":8192,
	"水产":16384	
}

# 在现有的food里面,添加recipe 属性即可.材料可以重复,但最好不要,会方便点.
var food = {}
var dishes = []
var select = []
var recipe = []

var level = 3		
var prepare_dishes = []
var db_dishes = []

# 更新ui基本信息
func update_cook_ui():
	$MarginContainer/VBoxContainer/Goal.bbcode_text = "请烹饪:[color=yellow]" + food.name + "[/color]"
# 生成食物烹饪点数(配方不同的食物,烹饪点数不同)
func create_food_point(recipe):
	var point = 0
	var p = 0
	for r in recipe :
		p = recipes[r]
		point = point + p
	return point
				
# 配方与选项进行比较	
func match_recipe(recipe:Array,select:Array):
	recipe.sort()
	select.sort()
	var r_size = recipe.size()
	var s_size = select.size()
	
	var match_rs = []
	var match_sr = []
	
	for i in range(s_size):
		if recipe.has(select[i]):
			match_rs.append(i)
	
	for j in range(r_size):
		if select.has(recipe[j]):
			match_sr.append(j)
	
#	比对结果排序,方便下一步统计
	match_rs.sort()
	match_sr.sort()
	
#	数组删除,需要从尾部开始
	for s in range(match_rs.size()-1,-1,-1):
		select.remove(match_rs[s])
		
	for r in range(match_sr.size()-1,-1,-1):
		recipe.remove(match_sr[r])
	
	# 计算扣分
	var deduction1 = 0
	var deduction2 = 0
	
	for d1 in recipe:
		print_debug(d1)
		deduction1 = deduction1 + recipes[d1]
		
	for d2 in select:
		deduction2 = deduction2 + recipes[d2]	
#	print_debug(str(match_rs)," vs ",str(match_sr))
#	print_debug("你的选择:",str(select)," vs ","配方:",str(recipe))
	var des = ""
	if recipe.size() > 0 :
		des += "相对于配方,你少放了[color=yellow]{r}[/color],扣除[color=red]{n}[/color]配方点\n".format({"r":str(recipe),"n":deduction1})
	if select.size()>0 :
		des += "相对于配方,你多放了[color=red]{r}[/color],扣除[color=red]{n}[/color]配方点\n".format({"r":str(select),"n":deduction2})
	var food_p = create_food_point(recipe)
#	var score = (food_p - deduction1 - deduction2)/food_p*2000
	var score = food_p
	des += "总评分[color=orange]" + str(score) +"[/color]"+ rank(score)
		
	$MarginContainer/VBoxContainer/description.bbcode_text = des
	
	
	
func rank(point:int):
	if point > 1000 :
		return "[color=gold]完美!!![/color]"
	if point > 800 :
		return "[color=cyan]杰作!![/color]"
	if point > 600 :
		return "[color=lime]精品![/color]"
	if point > 400 :
		return "成品"
	if point > 200 :
		return "[color=lightslategray]马马虎虎[/color]"
	if point > 0 :
		return "[color=olive]这是人吃的么?!?!"
	if point <= 0 :
		return "[color=red]你这是想谋财害命吧!!!![/color]"

	func 等级(point:int):
		if point > 1000 :
			return "[color=gold]完美!!![/color]"
		if point > 800 :
			return "[color=cyan]杰作!![/color]"
		if point > 600 :
			return "[color=lime]精品![/color]"
		if point > 400 :
			return "成品"
		if point > 200 :
			return "[color=lightslategray]马马虎虎[/color]"
		if point > 0 :
			return "[color=olive]这是人吃的么?!?!"
		if point <= 0 :
			return "[color=red]你这是想谋财害命吧!!!![/color]"		

var buttons = []
	
func connect_buttons_pressed():
	buttons = [
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Action0,
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Action1,
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Action2,
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Action3,
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Action4,
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Action4,
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Action5,
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Action6,
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Action7,
	$MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Action8,
	$MarginContainer/VBoxContainer/HBoxContainer2/material0,
	$MarginContainer/VBoxContainer/HBoxContainer2/material1,
	$MarginContainer/VBoxContainer/HBoxContainer2/material2,
	$MarginContainer/VBoxContainer/HBoxContainer2/material3,
	$MarginContainer/VBoxContainer/HBoxContainer2/material4,
	]
	for b in buttons :
		b.connect("button_down",self,"add_material",[b.text])
	pass
	
	var complete = $MarginContainer/VBoxContainer/complete
	complete.connect("button_down",self,"match_recipe",[recipe,select])
	
	var next = $MarginContainer/VBoxContainer/next
	next.connect("button_down",self,"next_dish")
	
func add_material(material:String):
	select.append(material)		
	print_debug(select)	
	
# 下一道菜	
func next_dish():
	if prepare_dishes.size() > 0 :
		select.clear()
		new_random_dish()
		update_cook_ui()
	else:
		$Complete.dialog_text = "所有菜已经做好!\n辛苦了,去大厅休息一下吧."
		$Complete.show()
		$Complete.connect("confirmed",get_tree(),"change_scene",["res://stages/Main.tscn"])
	pass


func init_db_dishes():
	db_dishes = Global.load_data("res://data/dishes.json").duplicate()
	for i in range(db_dishes.size()):
		db_dishes[i].recipe = Array(db_dishes[i].recipe.split(","))
	db_dishes.shuffle()
	print_debug(db_dishes[0])
		
func init_prepare_dishes():
	$Dishes/PrepareDishes.bbcode_text = "[color=yellow]待做菜肴[/color]\n"
	for i in range(level):
		prepare_dishes.append(db_dishes[i])
		$Dishes/PrepareDishes.bbcode_text += db_dishes[i].name + "\n"
	food = prepare_dishes.front()
	recipe = food.recipe		

# 随机获取下一道菜
func new_random_dish():
#	db_dishes.shuffle()
#	food = db_dishes.front().duplicate()
	food = prepare_dishes.front()
	recipe = food.recipe
	prepare_dishes.pop_front()
	print_debug(prepare_dishes.size())
	pass

func _ready() -> void:
	randomize()
	init_db_dishes()
	init_prepare_dishes()
	connect_buttons_pressed()
	update_cook_ui()
#	match_recipe(recipe,select)
	pass # Replace with function body.

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://stages/Main.tscn")
	pass # Replace with function body.

