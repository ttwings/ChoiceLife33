extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	行为事件.connect("on_开始炼丹",self,"do_开始炼丹")
	行为事件.connect("on_选择丹方",self,"do_选择丹方")
	pass # Replace with function body.




func do_开始炼丹():
	print("开始炼制丹药")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func do_选择丹方():
	print("选择丹方")


func _on_Button_pressed():
	行为事件.emit_signal("on_开始炼丹")
	pass # Replace with function body.


func _on_丹成_pressed():
	行为事件.emit_signal("on_灵丹出炉")
	pass # Replace with function body.
