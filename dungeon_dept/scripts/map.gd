class_name Map
extends Control

@onready var room_manager: RoomManager = %RoomManager
@onready var click_player = $ClickPlayer
@onready var money_indicator = $Money
@onready var quota_indicator = $Quota
@onready var button1 = $Button
@onready var button2 = $Button2
@onready var button3 = $Button3


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_map"):
		if room_manager.active_room.room_is_ready():
			Soundtrack.stop_battle_music()
			Soundtrack.play_menu_music()
		room_manager.clear_active()
		self.visible = true
		
	money_indicator.text = "TOTAL: $" + str(money_engine.money)
	quota_indicator.text = "QUOTA: $" + str(money_engine.quota)


func _on_button_pressed() -> void:
	click_player.play()
	room_manager.active_room_index = 0
	room_manager.change_room()
	if room_manager.active_room.room_is_ready():
		Soundtrack.stop_menu_music()
		Soundtrack.play_battle_music()
	self.visible = false


func _on_button_2_pressed() -> void:
	click_player.play()
	room_manager.active_room_index = 1
	room_manager.change_room()
	if room_manager.active_room.room_is_ready():
		Soundtrack.stop_menu_music()
		Soundtrack.play_battle_music()
	self.visible = false


func _on_button_3_pressed() -> void:
	click_player.play()
	room_manager.active_room_index = 2
	room_manager.change_room()
	if room_manager.active_room.room_is_ready():
		Soundtrack.stop_menu_music()
		Soundtrack.play_battle_music()
	self.visible = false
