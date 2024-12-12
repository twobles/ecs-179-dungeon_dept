class_name BuildMenu
extends Node

signal battle_start

@onready var ui_block = $UIBlock
@onready var area = $UIBlock/BoardArea
@onready var entity_manager = %EntityManager
@onready var monster_factory := MonsterFactory.new()
@onready var monster_sprite_factory := MonsterSpriteFactory.new()
@onready var click_player = $UIBlock/VBoxContainer/Ready/ClickPlayer

var curr_monster_icon: Sprite2D
var curr_monster_instance: Monster

var mon_table = {
	1: Skeleton.new(),
	2: Slime.new(),
	3: Golem.new()
}

var monster_index: int
var mouse_pos_valid: bool = false
var icon_pos_valid: bool = true
var selected: bool = false
var holding: bool = false
var battle_start_emitted: bool

func _process(_delta: float) -> void:	
	if holding:
		curr_monster_icon.position = area.get_global_mouse_position()

	if not mouse_pos_valid:
		return
	
	if Input.is_action_just_pressed("place") and holding and icon_pos_valid:
		if (entity_manager.deduct_capacity(mon_table[monster_index].cost)):
			curr_monster_instance = monster_factory.spawn(
					mon_table[monster_index].type, 
					area.get_global_mouse_position()
			)
			curr_monster_instance.process_mode = Node.PROCESS_MODE_DISABLED
			curr_monster_instance.connect("mouse_entered", _on_mouse_over_placed)
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
	curr_monster_icon = monster_sprite_factory.spawn(
				mon_table[monster_index].type, 
				area.get_global_mouse_position()
	)
	add_child(curr_monster_icon)
	holding = true


func _on_ready_pressed() -> void:
	click_player.play()
	ui_block.visible = false
	emit_signal("battle_start")
	battle_start_emitted = true


func _on_board_area_mouse_entered() -> void:
	if curr_monster_icon != null:
		curr_monster_icon.visible = true
	mouse_pos_valid = true


func _on_board_area_mouse_exited() -> void:
	if curr_monster_icon != null:
		curr_monster_icon.visible = false
	mouse_pos_valid = false
	

func _on_area_2d_area_entered(_area: Area2D) -> void:
	icon_pos_valid = false


func _on_area_2d_area_exited(_area: Area2D) -> void:
	icon_pos_valid = true
	

func _on_placed_area_entered(_area: Area2D) -> void:
	print("invalid")
	
	
func _on_placed_area_exited(_area: Area2D) -> void:
	print("valid")
	
	
func _on_mouse_over_placed() -> void:
	print("hovering")


func _remove_curr_icon() -> void:
	if curr_monster_icon == null:
		return
	curr_monster_icon.queue_free()
	curr_monster_icon = null
	holding = false
	selected = false
