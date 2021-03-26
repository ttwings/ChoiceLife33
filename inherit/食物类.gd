extends Item

class_name Food


# 点击, 吃, 变质
signal 点击
signal 品味中
signal 变质中

# signal hit
# signal do_eat()
# signal decay()
# signal do_test

# onready var label = $Label
# onready var animal = $AnimationPlayer
# onready var area = $Area2D

onready var 标签 = $Label
onready var 动画 = $AnimationPlayer
onready var 区域 = $Area2D


func _ready():
	标签.text = "name"
	$Panel/RichTextLabel.bbcode_text = str(query("long"))
	connect("notify_fail",self,"on_notify_fail")
	connect("do_eat",self,"do_eat")
	connect("decay",self,"decay")
	connect("do_test",self,"_on_do_test")

func _input(event):
	if event.is_action("左键") :
		# emit_signal("do_test",1,2,3)
#		$Panel.show()
		动画.play("do_eat")	

func on_提醒错误(msg):
	print_debug(msg)

func do_食用(角色):
#	if( !living(this_player()) || this_player().query_temp("noliving") )
#		return 1;
	if 角色.查询("精力")<0 || 角色.查询("气") < 0 ：
		return do_失败通知("你太累了,是在没力气吃什么了. \n ")
	# if character.query("jing")<0 || character.query("qi")<0 :
	# 	return notify_fail("你太累了，实在没力气吃什么了。\n");
#	if( !this_object().id(arg) ) return 0;
#	if( !present(this_object(), this_player()))
#		return notify_fail("你要吃什么东西？\n");
#	if( this_player().is_busy() )
#		return notify_fail("别急，慢慢吃，小心别噎着了。\n");
	if query("food_remaining")<= 0 :
		return notify_fail( name() + "已经没什么好吃的了。\n");
	if( character.query("food") >= character.max_food_capacity() ):
		return notify_fail("你已经吃太饱了，再也塞不下任何东西了。\n");
#
	character.add("food", query("food_supply"));

#	if( this_player().is_fighting() ) this_player().start_busy(2);
#
#	// This allows customization of drinking effect.
#	if( query("eat_func") ) return 1;
#
	set("value", 0);
	add("food_remaining", -1);

	if( query("food_remaining") == 0 ):
		return message_vision("$N将剩下的"+name()+"吃得干干净净。\n",character);
#		if( !this_object().finish_eat() ):
		destruct(this_object());
	else:
		return message_vision("$N拿起" + name()+"咬了几口。\n",character);
# //	this_player().start_busy(1);
#	return 1;
#}
	# print("do_eat")
	pass


func 变质中():
	var me = self
	var ob = get_parent()
	if (!me || !ob) :
		return;
	match(add("变质", 1)):
		2:
			set_temp("apply/long",query("long")+"可是看起来不是很新鲜。\n");
			tell_object(ob, me.name()+"的颜色有些不对了。\n");
		3:
			set_temp("apply/long", query("long")+"可是正在散发出一股难闻的味道。\n");
			tell_object(ob,me.name()+"散发出一股难闻的味道。\n");
		4:
			set_temp("apply/long",query("long")+"可是有些腐烂了。\n");
			tell_object(ob,me.name()+"有些腐烂了，发出刺鼻的味道。\n");
		_:
			tell_object(ob,me.name()+"整个腐烂掉了。\n");
			destruct(this_object());
