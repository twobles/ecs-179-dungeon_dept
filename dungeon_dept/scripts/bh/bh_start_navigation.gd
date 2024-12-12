class_name StartNavigation extends ActionLeaf

func tick(actor:Node, _blackboard:Blackboard) -> int:
	#print("navigating")
	actor.face_target()
	actor.walking = true
	actor.toggle_navigation(true)
	return SUCCESS
