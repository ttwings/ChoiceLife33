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
var food = {
	"name" : "麻婆豆腐",
	"recipe" : ["谷面","炸炒","辛辣"]
}

var select = ["谷面","炸炒","辛辣"]

func create_food_point(food):
	var point = 0
	var p = 0

	for r in food.recipe :
		p = recipes[r]
		point = point + p

	print_debug(point)
	return point			
	
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
	
#	print_debug(match_rs,match_sr)		
	
	match_rs.sort()
	match_sr.sort()
	
	for s in range(match_rs.size()-1,-1,-1):
		select.remove(match_rs[s])
		
	for r in range(match_sr.size()-1,-1,-1):
		recipe.remove(match_sr[r])
	
#	print_debug(str(match_rs)," vs ",str(match_sr))
#	print_debug("你的选择:",str(select)," vs ","配方:",str(recipe))
	var des = ""
	if recipe.size() > 0 :
		des += "相对于配方,你少放了[color=yellow]" + str(recipe) + "[/color]\n"
	if select.size()>0 :
		des += "相对于配方,你多放了[color=red]{r}[/color],扣除[color=red]{n}[/color]评价点\n".format({"r":str(select),"n":32})
	var score = 900
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
	complete.connect("button_down",self,"match_recipe",[food.recipe,select])
	
	var next = $MarginContainer/VBoxContainer/next
	next.connect("button_down",self,"next_dish")
	
func add_material(material:String):
	select.append(material)		
	print_debug(select)	
	
# 下一道菜	
func next_dish():
	
	pass	

func _ready() -> void:
#	create_food_point(food)
	select.clear()
	connect_buttons_pressed()
	match_recipe(food.recipe,select)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
