class_name Room
extends Node

@export var connected_rooms: Array[Room] = []

@onready var entity_manager = $EntityManager
@onready var build_ui = $BuildUI
@onready var active_room: bool = false

var paused = true


func _ready() -> void:
	if not active_room:
		self.visible = false
		pause()
	else:
		return
			
	
func pause() -> void:
	entity_manager.process_mode = Node.PROCESS_MODE_DISABLED
	build_ui.process_mode = Node.PROCESS_MODE_DISABLED
	paused = true
	

func unpause() -> void:
	entity_manager.process_mode = Node.PROCESS_MODE_INHERIT
	build_ui.process_mode = Node.PROCESS_MODE_INHERIT
	paused = false
