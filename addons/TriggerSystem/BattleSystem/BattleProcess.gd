extends Node

func damageProcess(dmgObj:DmgObj):
	var from = dmgObj.from
	var to = dmgObj.to
	if to.state == "die" || from.state == "die":
		return
	