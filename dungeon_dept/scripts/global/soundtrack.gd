extends Node

@onready var menu_soundtrack: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var battle_soundtrack: AudioStreamPlayer = AudioStreamPlayer.new()
var signal_count: int = 0

func _ready() -> void:
	add_child(menu_soundtrack)
	menu_soundtrack.stream = preload("res://sounds/Music/Goblins_Den_(Regular).ogg")   
	menu_soundtrack.play()

func play_battle_music() -> void:
	stop_menu_music()
	add_child(battle_soundtrack)
	battle_soundtrack.stream = preload("res://sounds/Music/Goblins_Dance_(Battle).ogg")
	battle_soundtrack.play()
	
func stop_menu_music() -> void:
	if menu_soundtrack.playing:
		menu_soundtrack.stop()

func play_menu_music() -> void:
	if not menu_soundtrack.playing:
		menu_soundtrack.play()
		
func stop_battle_music() -> void:
	if battle_soundtrack.playing:
		battle_soundtrack.stop()
