extends Node

var foods
var herbs
var user_class
var player
var castleDB

var herbs_list = []
var foods_list = []
var user_class_list = []
var player_list = []
var castle_list = []

# 全局房间字典，key为房间路径，v为实例
var all_current_rooms = {}
func load_room(path)
	if all_current_rooms[path] == null
		all_current_rooms[path] = Room(path)

func load_room(path:String):
	if all_current_rooms.has(path):
		return all_current_rooms[path]
	else:
		var room = load(path).new()
		all_current_rooms[path] = room
		return room

# 保存房间数据
func save_current_rooms():
	for path in all_current_rooms:
		ResourceSaver.save(path,all_current_rooms[path])		

# 从数据字典,生成角色
func creat_user(file):
	var user = load(file).new()
	var player = Char.new()
	player.dbase = user.dbase
	return player

# Called when the node enters the scene tree for the first time.
func _ready():
#	player = creat_user("res://data/user/l/lijia.gd")
	pass # Replace with function body.


func save():
	var  save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent(),
		#"pos_x" : position.x,
		#"pos_y" : position.y,
		
		}
	return save_dict

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save",File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
	
	save_game.open("user://savegame.save",File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		var new_object = load(current_line["filename"]).instance()
		get_node(current_line["parent"].add_child(new_object))
		new_object.position = Vector2(current_line["pos_x"],current_line["pos_y"])
		for i in current_line.keys():
			if i == "filename" or i== "parent" or i == "pos_x" or i == "pos_y" :
				continue
			new_object.set(i,current_line[i])
	save_game.close()
	
# 读取JSON格式的数据文件	
func load_data(path:String):
	var load_data = File.new()
	if not load_data.file_exists(path):
		print_debug("not exists file")
		return
	
	load_data.open(path,File.READ)

	var data_str = load_data.get_as_text()
	var p = JSON.parse(data_str)
	castleDB = p
	return p.result

func get_sheet(sheet_name:String,dbase):
	var sheet_json = {}
	var sheet = dbase["sheets"][sheet_name]
	if sheet:
		for line in sheet["lines"]:
			sheet_json[line["id"]] = line
	return sheet_json	

func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

# 获取path目录下特定后缀suffix文件

func dir_files(path,suffix):
	var dir = Directory.new()
	var files = []
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name!= ""):
			if dir.current_is_dir():
				print("Found directory" + file_name)
			elif file_name.split(".")[-1] == suffix:
				files.append(file_name)
				print("Found file: " + file_name)
			else:
				pass
				#print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error ccurred when trying to access the path.")
	return files	

# 获取目录path下的suffix后缀图片文件生成anim名称的 sprite frames	

func creat_sprite_frames_from_path(anim:String,path:String,suffix:String):
	var sprite_files = dir_files(path,suffix)
	var sprite_frames = SpriteFrames.new()
	var texture
	#sprite_frames.add_animation(anim)
	for i in sprite_files.size() :
		texture = load(path + "/" + sprite_files[i])
		sprite_frames.add_frame(anim,texture)
	return sprite_frames
						
# 依据数值 改变颜色名称

func get_number_color(number):
	if number < 0: 
		return "red" 
	else:
		return "green"
		
# 将整数数字转为中文文字	
func get_chinese_number(n:int):
	var number_str = str(n)
	var l = number_str.length()
	var output = []
	for i in range(l):
		number_str[i] = swap_to_font(number_str[i])
	return number_str
# 配合上面转化		
func swap_to_font(number):
	match number:
		"1",1:return "一"
		"2",2:return "二"
		"3",3:return "三"
		"4",4:return "四"
		"5",5:return "五"
		"6",6:return "六"
		"7",7:return "七"
		"8",8:return "八"
		"9",9:return "九"
		"0",0:return "〇"
		"-",0:return "负"
		_:return "X"	
		
func digit_to_char(number):
	match number:
		"1",1:return "一"
		"2",2:return "二"
		"3",3:return "三"
		"4",4:return "四"
		"5",5:return "五"
		"6",6:return "六"
		"7",7:return "七"
		"8",8:return "八"
		"9",9:return "九"
		"0",0:return "〇"
		_:return "X"			

# 返回当前玩家
func this_player():
	return player

#################################  延迟调用  ##############################
# update call
func update_call(dell):
	pass

	
#func update_call(delta):
#	# var delta = get_process_delta_time()
#	for c in call_funcs :
#		call_funcs[c] -= delta
#		if call_funcs[c] <= 0 :
##			call_func(c)
#			call_funcs.erase(c)	

################################
var books
var db
#var foods = []
#func _ready():
#	db = load_cdb()
#	foods = load_db_sheet(db,"foods")
#	print(query(db_json,0,0))
#	print(foods)
#	pass # Replace with function body.

func load_cdb():
	var db
	var file = File.new()
	file.open("res://gamedata/data.cdb",File.READ)
	db = parse_json(file.get_as_text())
	file.close()
	return db
	

func load_db_sheet(db,sheet_name:String):
	var sheet_json = {}
	for sheet in db["sheets"]:
		if sheet["name"] == sheet_name :
#			sheet_json = sheet
			for entry in sheet["lines"]:
				var new_entry = entry.duplicate()
#				sheet_json.push_back(new_entry)
#				new_entry.erase("id")
				sheet_json[entry["id"]] = new_entry
	return sheet_json	
	
func save_db_sheet(db,sheet_name,sheet_data):
	for sheet in db["sheets"]:
		if sheet["name"] == sheet_name:
			sheet["name"] = sheet_data.duplicate()	

