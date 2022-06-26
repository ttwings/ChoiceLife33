extends Node

# 计算在视野范围内的格子数组
# 数据地图 = 格子坐标数据
# 墙壁索引 = 数据题图里面,被光线照射到的墙壁
# 原始 = 原始的坐标,来源于FOV
# 半径 = 计算半径

func calc_FOV(地图数据,墙壁索引,原始格子,计算半径,遮挡=[]):
	var 数据 = 地图数据
	for cell in 遮挡:
		数据[cell.x][cell.y] = 墙壁索引
	var 范围 = get_fov_矩形(原始,半径)
	pass


func get_fov_rec(原始,半径):
	var x = 原始.x - 半径
	var y = 原始.y - 半径
	var s = 1 + (半径*2)
	return Rect2(Vector2(x,y),Vector2(s,s))

func is_墙壁(数据,墙壁索引,格子):
	return 数据[格子.x][格子.y] == 墙壁索

func get_fov(args):
	var v = Vector2()
