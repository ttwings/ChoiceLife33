extends Node

# const color -----------------------------------
const NOR = "[/color]"
const BLK = "[color=#000000]"
const RED = "[color=#ff0000]"
const GRN = "[color=#00ff00]"
const YEL = "[color=#ffff00]"
const BLU = "[color=#0000ff]"
const MAG = "[color=#ff00ff]"
const CYN = "[color=#00ffff]"
const WHT = "[color=#ffffff]"   
const HIR = "[color=#ff0000]"
const HIG = "[color=#00ff00]"
const HIY = "[color=#ffff00]"
const HIB = "[color=#44cef6]"
const HIM = "[color=#ff00ff]"
const HIC = "[color=#177cb0]"
const HIW = "[color=#e9e7ef]"
const BRED = "[color=#ff2121]"
const BGRN = "[color=#00e500]"
const BYEL = "[color=#ffb61e]"
const BBLU = "[color=#4b5cc4]"
const BMAG = "[color=#8d4bbb]"
const BCYN = "[color=#1685a9]"
const HBRED = "[color=#ff2121]"
const HBGRN = "[color=#40de5a]"
const HBYEL = "[color=#eacd76]"
const HBBLU = "[color=#3b2e7e]"
const HBMAG = "[color=#815463]"
const HBCYN = "[color=#00e09e]"
const HBWHT = "[color=#f0fcff]"

const COLOR0 = Color.black
const COLOR1 = Color.white
const COLOR2 = Color.yellow
const COLOR3 = Color.green
const COLOR4 = Color.greenyellow
const COLOR5 = Color.dodgerblue
const COLOR6 = Color.aqua
const COLOR7 = Color.purple
const COLOR8 = Color.deeppink
const COLOR9 = Color.red

const direction = {
	"北":    Vector2(0,-1),
	"东北":   Vector2(1,-1),
	"东":    Vector2(1,0),
	"东南":   Vector2(1,1),
	"南":    Vector2(0,1),
	"西南":   Vector2(-1,1),
	"西":    Vector2(-1,0),
	"西北":   Vector2(-1,-1),
	}
	
var game
var map
var player

var player_data = {
	"名称":		"张三",
	"性别":		"男",
	"种族":		"人类",
	"职业":		"流浪者",
	"经验":		0,
	}
	
var message_panel
var message_battle = false    

func save_game():
	var file = File.new()
	var data = game.get_game_data()
	var open = file.open("res://SAVE.json", File.WRITE)
	if !open==OK: 
		print("无法打开!")
		return
	file.store_line( to_json( data ) )
	file.close()
	

func roll( n, m ):
	return int( round( rand_range( n, m ) ) )	

	
func attack( attacker, target ):
	# hit or miss this attack roll
	var hit = false
	# attacker's weapon damage roll
	var damage = attacker.battle.get_weapon_damage()
	# attack dic roll
	var attack_roll = roll(1,30)
	# attacker to-hit bonus
	var attack_bonus = attacker.battle.get_bonus()
	# target's AC
	var ac = attacker.battle.get_target_ac()
	
	# attack hits if modified attack roll meets/beats target AC
#	# hits = attack_roll + attack_bonus >= ac
	var hits
	hits = attack_roll + attack_bonus
	hit = hits >= ac
	# always hit on a natural 28+
	if attack_roll >= 28:
		hit = true
	# always miss on a natural 1
	if attack_roll <= 1:
		hit = false
	
	# Throw messages
	if message_battle:
		var hit_text = ["失误!","击中!"][int(hits)]
		var roll_text = ">> 攻击力 %s: 1d30+%s=%s(%s) vs 防御力 %s .. %s" % [attacker.get_message_name(), str(attack_bonus), str(attack_roll+attack_bonus), str(attack_roll), str(ac), hit_text]
#		RPG.messageboard.message( roll_txt )
	# Return combat result in dictionary form
	return {
		"hit":	hit,
		"damage":damage,
		}
	
