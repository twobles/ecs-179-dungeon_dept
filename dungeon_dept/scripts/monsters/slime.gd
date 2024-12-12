class_name Slime
extends Monster

func _ready() -> void:
	cost = 10
	type = MonsterFactory.MonsterType.SLIME
	sprite_path = "res://assets/slime.png"
	
