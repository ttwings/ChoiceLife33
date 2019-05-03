extends Node

func _ready() -> void:
	pass # Replace with function body.

var digit = 1
var digit1button5 = 0
var digit1button4 = 0
func update_label():
	$Label.text = Global.digit_to_char(digit1button4 + digit1button5)

func get_sum():
	return digit * (digit1button5 + digit1button4)

var suanpan_5_1 = preload("res://assets/graphics/ui/suanpan_5-1.png")
var suanpan_5_0 = preload("res://assets/graphics/ui/suanpan_5-0.png")
var suanpan_4_0 = preload("res://assets/graphics/ui/suanpan_4-0.png")
var suanpan_4_1 = preload("res://assets/graphics/ui/suanpan_4-1.png")
var suanpan_4_2 = preload("res://assets/graphics/ui/suanpan_4-2.png")
var suanpan_4_3 = preload("res://assets/graphics/ui/suanpan_4-3.png")
var suanpan_4_4 = preload("res://assets/graphics/ui/suanpan_4-4.png")

func _on_TextureButton50_pressed() -> void:
	if digit1button5 == 0 :
		digit1button5 = 5
		$"TextureButton5".texture_normal = suanpan_5_1
	else:
		digit1button5 = 0
		$"TextureButton5".texture_normal = suanpan_5_0
	print_debug(get_sum())
	update_label()
	pass # Replace with function body.

var number = 0
func _on_TextureButton14_pressed() -> void:
	number = (number + 1)%5
	match number:
		0:
			digit1button4 = 0
			$"TextureButton4".texture_normal = load("res://assets/graphics/ui/suanpan_4-0.png")
		1:
			digit1button4 = 1
			$"TextureButton4".texture_normal = load("res://assets/graphics/ui/suanpan_4-1.png")
		2:
			digit1button4 = 2
			$"TextureButton4".texture_normal = load("res://assets/graphics/ui/suanpan_4-2.png")
		3:
			digit1button4 = 3
			$"TextureButton4".texture_normal = load("res://assets/graphics/ui/suanpan_4-3.png")
		4:
			digit1button4 = 4
			$"TextureButton4".texture_normal = load("res://assets/graphics/ui/suanpan_4-4.png")
#		1:
#			digit1button4 = 1
#			$"TextureButton5-0".texture_normal = load("res://assets/graphics/ui/suanpan_4-1.png")
	print_debug(get_sum())
	update_label()
	pass # Replace with function body.
