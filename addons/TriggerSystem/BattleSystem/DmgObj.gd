extends Reference

class_name DmgObj

var from = null
var to = null
var dmg = 0
var isCrit = false
var canCrit = false
var critBaseDmg = 0
var critPower = 1
var type = 0
var rebound = true
var canDodge = false
var isDodge = false
var isNormalAttack = false

func _init(dic=null) -> void:
	if dic == null:
		return
	var keys = dic.keys()
	for key in keys:
		set(key,dic[key])