extends Action



func do():
	action_message = "%s %s %s" % [Owner.name,"move to ",direction]
	Owner.position = Owner.position + direction * Owner.step_size

