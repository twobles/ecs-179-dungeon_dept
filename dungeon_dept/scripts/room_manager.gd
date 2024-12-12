class_name RoomManager
extends Node

signal active_room_ready

@export var rooms: Array[Room] = []
@export var active_room: Room
@export var debug: bool = true

var active_room_index: int = 0
var is_playing: bool = false


func _ready() -> void:
	for room in rooms:
		room.connect("battle_end", change_next)
		room.connect("in_battle", room_ready)


func _process(_delta: float) -> void:
	if active_room == null:
		return
	
	if active_room.paused:
		active_room.visible = true
		active_room.unpause()

	if active_room.room_is_ready() and not is_playing:
		Soundtrack.play_battle_music()
		is_playing = true

	if not active_room.room_is_ready() and is_playing:
		Soundtrack.stop_battle_music()
		Soundtrack.play_menu_music()
		is_playing = false
		
	if Input.is_action_just_pressed("ui_accept") and debug:
		active_room_index = (active_room_index + 1) % rooms.size()
		change_room()


func _play_battle_music() -> void:
	Soundtrack.play_battle_music()


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
	#if active_room == null:
		#return
	#
	#for i in range(rooms.size()):
		#for adj_room in active_room.connected_rooms:
			#if adj_room == rooms[i]:
				#active_room_index = i
				#
	#change_room()
	pass
	
	
func room_ready() -> void:
	emit_signal("active_room_ready")
