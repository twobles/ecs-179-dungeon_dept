extends Node2D

@export var unflipped_position:Vector2
@export var flipped_position:Vector2

func flip(facing: Entity.Facing) -> void:
	if Entity.Facing.LEFT == facing:
		position = flipped_position
	elif Entity.Facing.RIGHT == facing:
		position = unflipped_position

func _on_skeleton_character_direction_change(facing: Entity.Facing) -> void:
	flip(facing)

func _on_golem_character_direction_change(facing: Entity.Facing) -> void:
	flip(facing)
