class_name Map
extends Control

@onready var room_manager: RoomManager = %RoomManager


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_map"):
		room_manager.clear_active()
		self.visible = true


func _on_button_pressed() -> void:
	room_manager.active_room_index = 0
	room_manager.change_room()
	self.visible = false


func _on_button_2_pressed() -> void:
	room_manager.active_room_index = 1
	room_manager.change_room()
	self.visible = false


func _on_button_3_pressed() -> void:
	room_manager.active_room_index = 2
	room_manager.change_room()
	self.visible = false
