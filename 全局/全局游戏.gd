extends Node

# const color -----------------------------------
const NOR = "[/color]"
const BLK = "[color=#000000]"
const RED = "[color=#ff0000]"
const GRN = "[color=#00ff00]"
const YEL = "[color=#ffff00]"
const BLU = "[color=#0000ff]"
const MAG = "[color=#ff0.0ff]"
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

const 杂项层 = 0
const 物品层 = 1
const 实体层 = 2
const 动画层 = 3

const 方向 = {
	"北":    Vector2(0,-1),
	"东北":   Vector2(1,-1),
	"东":    Vector2(1,0),
	"东南":   Vector2(1,1),
	"南":    Vector2(0,1),
	"西南":   Vector2(-1,1),
	"西":    Vector2(-1,0),
	"西北":   Vector2(-1,-1),
	}
	
var 游戏
var 地图
var 玩家

var 玩家数据 = {
	"名称":		"张三",
	"性别":		"男",
	"种族":		"人类",
	"职业":		"流浪者",
	"经验":		0,
	}
	
var 消息面板
var 详细战斗信息 = false    

func 保存游戏():
	var 文件 = File.new()
	var 数据 = 游戏.获得游戏数据()
	var 打开 = 文件.open("res://SAVE.json", File.WRITE)
	if !打开==OK: 
		print("无法打开!")
		return
	文件.store_line( to_json( 数据 ) )
	文件.close()
	

func 扔骰子( n, m ):
	return int( round( rand_range( n, m ) ) )	

	
func 执行攻击( 攻击者, 目标 ):
	# hit or miss this attack roll
	var 击中 = false
	# attacker's weapon damage roll
	var 伤害 = 攻击者.战斗.get_武器伤害()
	# attack die roll
	var 攻击骰子 = 扔骰子(1,30)
	# attacker to-hit bonus
	var 攻击优势 = 攻击者.战斗.get_攻击优势()
	# target's AC
	var 防御水平 = 攻击者.战斗.get_护甲类别()
	
	# attack hits if modified attack roll meets/beats target AC
	# hits = attack_roll + attack_bonus >= ac
	击中 = 攻击骰子 + 攻击优势 >= 防御水平
	# always hit on a natural 28+
	if 攻击骰子 >= 28:
		击中 = true
	# always miss on a natural 1
	if 攻击骰子 <= 1:
		击中 = false
	
	# Throw messages
	if 详细战斗信息:
		var 击中文本 = ["失误!","击中!"][int(击中)]
		var 骰子文本 = ">> 攻击力 %s: 1d30+%s=%s(%s) vs 防御力 %s .. %s" % [攻击者.get_信息名称(), str(攻击优势), str(攻击骰子+攻击优势), str(攻击骰子), str(防御水平), 击中文本]
#		RPG.messageboard.message( roll_txt )
	# Return combat result in dictionary form
	return {
		"击中":	击中,
		"伤害":	伤害,
		}
	
