class_name MonsterFactory
extends Node

enum MonsterType {
	SKELETON,
	SLIME,
	GOLEM,
}

var monster_paths = {
	MonsterType.SKELETON: "res://scenes/monsters/skeleton.tscn",
	MonsterType.SLIME: "res://scenes/monsters/slime.tscn",
	MonsterType.GOLEM: "res://scenes/monsters/golem.tscn",
}

var monster_cache = {}


func spawn(monster_type: MonsterType, pos: Vector2 = Vector2(0.0, 0.0)) -> Monster:
	if monster_type in monster_paths:
		if not monster_cache.has(monster_type):
			monster_cache[monster_type] = load(str(monster_paths[monster_type]))
		var monster_instance = (monster_cache[monster_type] as PackedScene).instantiate()
		monster_instance.position = pos
		return monster_instance as Monster
	else:
		print("error")
		return null
