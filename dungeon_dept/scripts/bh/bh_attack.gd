class_name Attack extends ActionLeaf

func tick(actor:Node, _blackboard:Blackboard) -> int:
	actor.toggle_navigation(false)
	actor.walking = false
	actor.attacking = true
	#print("attacking: ", actor.attacking )
	return SUCCESS
