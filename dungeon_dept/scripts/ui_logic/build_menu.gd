class_name BuildMenu
extends Node

signal battle_start

@onready var ui_block = $UIBlock
@onready var area = $UIBlock/BoardArea
@onready var entity_manager = %EntityManager
@onready var monster_factory: MonsterFactory = MonsterFactory.new()
@onready var adventurer_factory: AdventurerFactory = AdventurerFactory.new()

var curr_monster_icon: Sprite2D
var curr_monster_instance: Monster

var mon_table = {
	1: Skeleton.new(),
	2: Slime.new(),
	3: Golem.new()
}

var monster_index: int
var mouse_pos_valid: bool = false
var holding: bool = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spawn_monster_1") and curr_monster_icon == null:
		curr_monster_icon = Sprite2D.new()
		curr_monster_icon.texture = load(mon_table[1].sprite_path)
		curr_monster_icon.scale = Vector2(0.35, 0.35)
		curr_monster_icon.position = area.get_global_mouse_position()
		add_child(curr_monster_icon)
		monster_index = 1
		holding = true
		
	if holding:
		curr_monster_icon.position = area.get_global_mouse_position()
		
	if not mouse_pos_valid:
		return
		
	if Input.is_action_just_pressed("place") and holding:
		_remove_curr_icon()
		if (entity_manager.deduct_capacity(mon_table[monster_index].cost)):
			curr_monster_instance = monster_factory.spawn(
				mon_table[monster_index].type, 
				area.get_global_mouse_position()
			)
			curr_monster_instance.process_mode = Node.PROCESS_MODE_DISABLED
			entity_manager.add_child(curr_monster_instance)
			entity_manager.monsters.push_back(curr_monster_instance)
		holding = false


func _remove_curr_icon() -> void:
	if curr_monster_icon == null:
		return
	curr_monster_icon.queue_free()
	curr_monster_icon = null


func _on_ready_pressed() -> void:
	ui_block.visible = false
	emit_signal("battle_start")
	

func _on_board_area_mouse_entered() -> void:
	mouse_pos_valid = true


func _on_board_area_mouse_exited() -> void:
	mouse_pos_valid = false
