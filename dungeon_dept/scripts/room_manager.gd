class_name RoomManager
extends Node

@export var rooms: Array[Room] = []
@export var active_room: Room
@export var debug: bool = true

var active_room_index: int = 0


func _ready() -> void:
	for room in rooms:
		room.connect("battle_end", change_next)


func _process(_delta: float) -> void:
	if active_room == null:
		return
	
	if active_room.paused:
		active_room.visible = true
		active_room.unpause()

	if Input.is_action_just_pressed("ui_accept") and debug:
		active_room_index = (active_room_index + 1) % rooms.size()
		change_room()


func change_room() -> void:
	if active_room != null:
		active_room.visible = false
		active_room.pause()
	
	active_room = rooms[active_room_index]
	active_room.visible = true
	active_room.unpause()
	

func clear_active() -> void:
	if active_room != null:
		active_room.visible = false
		active_room.pause()
		active_room = null
		
		
func change_next() -> void:
	if active_room == null:
		return
	
	for i in range(rooms.size()):
		for adj_room in active_room.connected_rooms:
			if adj_room == rooms[i]:
				active_room_index = i
				
	change_room()
