extends Node

@onready var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(audio_player)
	audio_player.stream = preload("res://sounds/Music/Goblins_Den_(Regular).ogg")  # Replace with your soundtrack file
	audio_player.volume_db = -5  # Adjust volume as needed
	audio_player.play()

func stop_music() -> void:
	if audio_player.playing:
		audio_player.stop()

func play_music() -> void:
	if not audio_player.playing:
		audio_player.play()
