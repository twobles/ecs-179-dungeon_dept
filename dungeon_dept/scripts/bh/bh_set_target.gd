class_name SetTarget extends ActionLeaf

func tick(actor:Node, _blackboard:Blackboard) -> int:
	#print("set target")
	actor.set_target_position(actor.enemy.global_position)
	return SUCCESS
