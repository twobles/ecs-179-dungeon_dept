class_name AdventurerManager
extends Node

@export var adventurers: Array[Adventurer] = []

@onready var room_manager: RoomManager = %RoomManager

var spawn_points = [
	Vector2(570.0, 525.0),
	Vector2(650.0, 525.0),
	Vector2(490.0, 525.0),
]


func _on_room_manager_active_room_ready() -> void:
	var active_room: Room = room_manager.active_room
	adventurers[0].z_index = active_room.z_index
	adventurers[1].z_index = active_room.z_index
	adventurers[2].z_index = active_room.z_index
	adventurers[0].position = Vector2(570.0, 525.0)
	adventurers[1].position = Vector2(650.0, 525.0)
	adventurers[2].position = Vector2(490.0, 525.0)
	
