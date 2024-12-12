class_name EntityManager
extends Node

signal battle_end
signal in_battle

@export var capacity: int = 100

@onready var capacity_indicator: Label = %Capacity

var monsters: Array[Monster] = []
var battling: bool = false


func _process(_delta: float) -> void:
	capacity_indicator.text = "CAPACITY: " + str(capacity)
	
	if battling and monsters.is_empty():
		emit_signal("battle_end")
	

func _physics_process(_delta: float) -> void:
	pass
	
	
func deduct_capacity(cost: int) -> bool:
	if (capacity - cost >= 0):
		capacity -= cost
		return true
	return false


func _on_build_ui_battle_start() -> void:
	for monster in monsters:
		monster.process_mode = Node.PROCESS_MODE_INHERIT
	battling = true
	emit_signal("in_battle")
