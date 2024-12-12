class_name StartMenu
extends Control

const GAME_SCENE = "res://scenes/cutscene.tscn"

@onready var click_player = $VBoxContainer/ClickPlayer

	
func _on_play_pressed() -> void:
	click_player.play()
	get_tree().change_scene_to_file(GAME_SCENE)


func _on_options_pressed() -> void:
	click_player.play()
