extends BehaviorTreeNodeAction

# override
func enter():
	print_debug("is dead coming")
	pass

# override
func exit():
	print_debug("daoxiao")
	pass

# override
func execute():
	print_debug("is dieing")
	return BTNResult.RUNNING
