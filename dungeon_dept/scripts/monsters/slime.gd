class_name Slime
extends Monster

@onready var slime_sfx: AudioStreamPlayer = AudioStreamPlayer.new()


func _init() -> void:
	cost = 10
	type = MonsterFactory.MonsterType.SLIME
	
	
func _ready() -> void:
	add_child(slime_sfx)
	slime_sfx.stream = preload("res://sounds/SFX/slime_sfx.wav")
	slime_sfx.play()
	melee_range = 90
	super()
	
	
func _process(_delta: float) -> void:
	pass
