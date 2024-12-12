class_name WaitMeleeRange extends ConditionLeaf

func tick(actor:Node, _blackboard:Blackboard) -> int:
	#print("wait melee: ", actor.check_melee_range())
	if actor.enemy == null:
		return RUNNING
	if actor.check_melee_range():
		return SUCCESS
	else:
		return RUNNING
