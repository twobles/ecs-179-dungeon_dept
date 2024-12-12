class_name Skeleton
extends Monster


func _init() -> void:
	cost = 20
	type = MonsterFactory.MonsterType.SKELETON



func _ready() -> void:
	melee_range = 40
	super()
