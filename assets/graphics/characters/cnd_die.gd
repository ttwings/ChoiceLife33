extends BehaviorTreeCondition

func check(btn:BehaviorTreeNode):
	var the_owner = btn.get_node_from_database("owner")
	return owner.is_dead
