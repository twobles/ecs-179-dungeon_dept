class_name Golem
extends Monster

func _ready() -> void:
	cost = 40
	type = MonsterFactory.MonsterType.GOLEM
	sprite_path = "res://assets/golem.png"
