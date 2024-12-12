class_name BuildMenu
extends Node

signal battle_start

@onready var ui_block = $UIBlock
@onready var area = $UIBlock/BoardArea
@onready var entity_manager = %EntityManager
@onready var monster_factory: MonsterFactory = MonsterFactory.new()
@onready var adventurer_factory: AdventurerFactory = AdventurerFactory.new()
@onready var click_player = $UIBlock/VBoxContainer/Ready/ClickPlayer
@onready var game_track = $UIBlock/VBoxContainer/Ready/Gametrack

var curr_monster_icon: Sprite2D
var curr_monster_instance: Monster

var mon_table = {
	1: Skeleton.new(),
	2: Slime.new(),
	3: Golem.new()
}

var monster_index: int
var mouse_pos_valid: bool = false
var selected: bool = false
var holding: bool = false


func _process(_delta: float) -> void:
	if holding:
		curr_monster_icon.position = area.get_global_mouse_position()

	if not mouse_pos_valid:
		return

	if Input.is_action_just_pressed("place") and holding:
		if (entity_manager.deduct_capacity(mon_table[monster_index].cost)):
			curr_monster_instance = monster_factory.spawn(
					mon_table[monster_index].type, 
					area.get_global_mouse_position()
			)
			curr_monster_instance.process_mode = Node.PROCESS_MODE_DISABLED
			entity_manager.add_child(curr_monster_instance)
			entity_manager.monsters.push_back(curr_monster_instance)
		_remove_curr_icon()

	if Input.is_action_just_pressed("clear_select"):
		_remove_curr_icon()

	if Input.is_action_just_pressed("spawn_monster_1"):
		monster_index = 1
		selected = true

	if Input.is_action_just_pressed("spawn_monster_2"):
		monster_index = 2
		selected = true

	if Input.is_action_just_pressed("spawn_monster_3"):
		monster_index = 3
		selected = true

	if not selected:
		return

	_remove_curr_icon()
	curr_monster_icon = Sprite2D.new()
	curr_monster_icon.texture = load(mon_table[monster_index].sprite_path)
	curr_monster_icon.scale = mon_table[monster_index].sprite_scale
	curr_monster_icon.position = area.get_global_mouse_position()
	add_child(curr_monster_icon)
	holding = true


func _on_ready_pressed() -> void:
	Soundtrack.stop_music()
	click_player.play()
	game_track.play()
	ui_block.visible = false
	emit_signal("battle_start")


func _on_board_area_mouse_entered() -> void:
	mouse_pos_valid = true


func _on_board_area_mouse_exited() -> void:
	mouse_pos_valid = false


func _remove_curr_icon() -> void:
	if curr_monster_icon == null:
		return
	curr_monster_icon.queue_free()
	curr_monster_icon = null
	holding = false
	selected = false
