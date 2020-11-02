extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var num1
var num2
var num3
func _ready():

	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("ui_down"):
		num1 = $Dice1.dice_num() + 1
		num2 = $Dice2.dice_num() + 1
		num3 = $Dice3.dice_num() + 1
		var t = ""
		var r = ""
		if num1 + num2 + num3 > 12 :
			t = "大"
		else:
			t = "小"
		r = str(num1) + str(num2) + str(num3) + t	
		r = "%d  %d  %d , %d 点 %s" % [num1,num2,num3,num1+num2+num3,t]
		$Label.text = r
		print(r)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

