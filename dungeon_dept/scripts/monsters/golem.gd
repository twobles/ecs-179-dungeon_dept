class_name Golem
extends Monster

func _init() -> void:
	cost = 40
	type = MonsterFactory.MonsterType.GOLEM
	sprite_path = "res://assets/golem.png"
	sprite_scale = Vector2(0.8, 0.8)

func _process(_delta: float) -> void:
	pass
