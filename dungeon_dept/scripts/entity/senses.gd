class_name Senses
extends Area2D

@export var current_enemies : Array[Node2D] = []
@export var current_entities : Array[Node2D] = []
@export var agent : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if agent == null:
		agent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_area_entered(area) -> void:
	#print("self: ", is_instance_of(self, Monster))
	#if area.team != self.team:
		#current_enemies.append(area)
	#else:
		#current_entities.append(area)
#
#
#func _on_area_exited(area) -> void:
	#current_entities.erase(area)
	#current_enemies.erase(area)
	#

func _on_body_entered(body: Node2D) -> void:
	print(agent,"; ", body)
	print("self: ", agent.team, "; body: ", body.team)
	if body == agent:
		return
		
	if body.team != agent.team:
		current_enemies.append(body)
		print("enemies: ", current_enemies)
	else:
		current_entities.append(body)


func _on_body_exited(body: Node2D) -> void:
	current_entities.erase(body)
	current_enemies.erase(body)	
	
	
func get_enemy() -> Node2D:
	if current_enemies.size() > 0:
		#print("getting: ", current_enemies[0])
		return current_enemies[0]
	else:
		return null
