class_name CheckMeleeRange extends ConditionLeaf

func tick(actor:Node, _blackboard:Blackboard) -> int:
	#print("check melee: ", actor.check_melee_range())
	if actor.enemy == null:
		return FAILURE

	if actor.check_melee_range():
		return SUCCESS
	else:
		return FAILURE
