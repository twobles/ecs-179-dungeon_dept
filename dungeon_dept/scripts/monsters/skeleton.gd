class_name Skeleton
extends Monster


func _ready() -> void:
	cost = 20
	type = MonsterFactory.MonsterType.SKELETON
	sprite_path = "res://assets/skeleton.png"

#
func _process(_delta: float) -> void:
	print("active")
	
