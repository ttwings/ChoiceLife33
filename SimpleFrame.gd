extends SimpleGameFramework

func _init():
	add_module('daily', DailyTask.new())
	add_module('timer', TimerModule.new())
	add_module('energe', GamePoint.new())
	add_module('buff', BuffModule.new())
	add_module('achievement', AchievementModule.new())

func _process(dt):
	logic_update(dt)


