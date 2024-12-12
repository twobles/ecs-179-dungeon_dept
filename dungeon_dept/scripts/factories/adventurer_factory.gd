class_name AdventurerFactory
extends Node

enum AdventurerType {
	KNIGHT,
	ARCHER,
	MAGE,
}

var adventurer_paths = {
	AdventurerType.KNIGHT: "res://scenes/adventurers/knight.tscn",
	AdventurerType.ARCHER: "res://scenes/adventurers/archer.tscn",
	AdventurerType.MAGE: "res://scenes/adventurers/mage.tscn",
}

var adventurer_cache = {}


func spawn(adventurer_type: AdventurerType, pos: Vector2 = Vector2(0.0, 0.0)) -> Adventurer:
	if adventurer_type in adventurer_paths:
		if not adventurer_cache.has(adventurer_type):
			adventurer_cache[adventurer_type] = load(str(adventurer_paths[adventurer_type]))
		var adventurer_instance = (adventurer_cache[adventurer_type] as PackedScene).instantiate()
		adventurer_instance.position = pos
		return adventurer_instance as Adventurer
	else:
		return null
