extends Node2D

onready var tween = $Tween

var state = "roll"
var num

func _ready() -> void:

	pass # Replace with function body.

func _process(delta: float) -> void:
	if state == "roll" :
		roll_dice(delta)
	elif state == "stop" :
		dice_num()

func _input(event):
	if event.is_action_pressed("ui_down"):
		state = "stop"
		randomize()
		num = randi()%6		
	if event.is_action_pressed("ui_up"):
		state = "roll"
		randomize()
		num = randi()%6	

var roll_dur = 0.05
var dur = roll_dur

# 骰子速度调整
func roll_dur_tween():
	tween.interpolate_property(self,"roll_dur", 0.2, 0.2, 0.3,Tween.TRANS_LINEAR , Tween.EASE_IN_OUT, 0)
	tween.start()

# 摇骰子
func roll_dice(delta :float):
	dur -= delta
	if dur <= 0 :
		$Sprite.frame = 6 + randi()%3
		dur = roll_dur
	 
# 停止
func dice_num():
	$Sprite.frame = num
	return num