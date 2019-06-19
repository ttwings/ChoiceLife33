extends Node2D

onready var tween = $Tween

func _ready() -> void:
#	tween = $Tween
	pass # Replace with function body.

func _enter_tree() -> void:
	roll_dur_tween()
	

func _process(delta: float) -> void:
	roll_dice(delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
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
	var num = randi()%6
	$Sprite.frame = num
	return num