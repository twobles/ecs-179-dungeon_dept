class_name Cutscene
extends Node
# Plays opening cutscene


const GAME_SCENE = "res://scenes/main.tscn"
var shots = [
	preload("res://assets/cutscene_shots/shot1_exterior1.png"),
	preload("res://assets/cutscene_shots/shot2_cubicle.png"),
	preload("res://assets/cutscene_shots/shot3_bbeg.png"),
	preload("res://assets/cutscene_shots/shot4_exterior2.png"),
]
var shots_text = [
	"It's another beautiful day of work at the Department of Dungeon Design! Here at the Department of Dungeon Design, we specialize in providing our clients with custom dungeons full of monsters to slay adventurers and protect their treasure!",
	"Each employee is tasked with earning money toward their daily quota at set rates for hurting adventurers, killing adventurers, and performing total party kills. However, if an adventuring party reaches the end of a dungeon and collects the client's treasure, a portion of money is taken OUT of your quota.",
	"If you meet your quotas and prove yourself a good employee, who knows?\nYou could rise up the ranks and become a BIG BOSS EXECUTIVE GUY, the most prestigious role and highest level of achievement in the land.",
	"Fail to hit your quotas... and you get kicked from our fine company.\n\nGood luck!",
]
var current_shot: int = 0
@onready var shot_display: Sprite2D = $Sprite2D
@onready var dialogue_display: Label = $DialogueBox/Dialogue


func _ready() -> void:
	shot_display.texture = shots[0]
	dialogue_display.text = shots_text[0]


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		current_shot += 1
		if current_shot >= shots.size():
			get_tree().change_scene_to_file(GAME_SCENE)
		else:
			shot_display.texture = shots[current_shot]
			dialogue_display.text = shots_text[current_shot]
