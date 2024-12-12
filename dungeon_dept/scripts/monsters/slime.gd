class_name Slime
extends Monster

func _init() -> void:
	cost = 10
	type = MonsterFactory.MonsterType.SLIME
	sprite_path = "res://assets/slime.png"

func _process(_delta: float) -> void:
	pass
