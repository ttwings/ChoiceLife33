extends Control

var sword = preload("res://item/weapon/sword/fireSword.tscn").instance()

func _ready():
	print(sword.melee)
