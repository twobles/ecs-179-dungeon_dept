class_name MonsterSpriteFactory
extends Node

enum MonsterType {
	SKELETON,
	SLIME,
	GOLEM,
}

var monster_paths = {
	MonsterType.SKELETON: "res://scenes/sprites/skeleton_sprite.tscn",
	MonsterType.SLIME: "res://scenes/sprites/slime_sprite.tscn",
	MonsterType.GOLEM: "res://scenes/sprites/golem_sprite.tscn",
}

var monster_cache = {}


func spawn(monster_type: MonsterType, pos: Vector2 = Vector2(0.0, 0.0)) -> Sprite2D:
	if monster_type in monster_paths:
		if not monster_cache.has(monster_type):
			monster_cache[monster_type] = load(str(monster_paths[monster_type]))
		var monster_instance = (monster_cache[monster_type] as PackedScene).instantiate()
		monster_instance.position = pos
		return monster_instance as Sprite2D
	else:
		print("error")
		return null
