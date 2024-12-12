class_name Room
extends Node

signal battle_end
signal in_battle

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
			
			
func room_is_ready() -> bool:
	return build_ui.battle_start_emitted
		
		
func pause() -> void:
	entity_manager.process_mode = Node.PROCESS_MODE_DISABLED
	build_ui.process_mode = Node.PROCESS_MODE_DISABLED
	paused = true
	

func unpause() -> void:
	entity_manager.process_mode = Node.PROCESS_MODE_INHERIT
	build_ui.process_mode = Node.PROCESS_MODE_INHERIT
	paused = false


func _on_entity_manager_battle_end() -> void:
	emit_signal("battle_end")


func _on_entity_manager_in_battle() -> void:
	emit_signal("in_battle")
