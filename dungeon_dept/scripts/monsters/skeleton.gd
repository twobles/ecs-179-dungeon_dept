class_name Skeleton
extends Monster

@onready var skeleton_sfx: AudioStreamPlayer = AudioStreamPlayer.new()

func _init() -> void:
	pass
	
func _ready() -> void:
	add_child(skeleton_sfx)
	skeleton_sfx.stream = preload("res://sounds/SFX/skeleton_sfx.wav")
	skeleton_sfx.play()

#
func _process(_delta: float) -> void:
	pass
	
