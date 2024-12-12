class_name Golem
extends Monster

@onready var golem_sfx: AudioStreamPlayer = AudioStreamPlayer.new()

func _init() -> void:
	cost = 40
	type = MonsterFactory.MonsterType.GOLEM
	
	
func _ready() -> void:
	add_child(golem_sfx)
	golem_sfx.stream = preload("res://sounds/SFX/golem_sfx.wav")
	golem_sfx.play()
	melee_range = 60
	super()


func _process(_delta: float) -> void:
	pass
