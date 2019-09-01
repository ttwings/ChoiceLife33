extends Node2D

export var live_time = 0.3
export var alfa_factor = 1
export(Color) var color = Color(1,1,1)

func _ready():
	$Timer.start(live_time)
	pass

func _process(delta: float) -> void:
	var alfa = $Timer.time_left * alfa_factor / live_time
	set("modulate",Color(color.r,color.g,color.b,alfa))	

func _on_Timer_timeout() -> void:
	queue_free()
