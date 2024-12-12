class_name Entity
extends CharacterBody2D

signal CharacterDirectionChange(facing:Facing)

enum Facing { 
	LEFT,
	RIGHT,
}


enum AttackType {
	PHYSICAL,
	MAGIC,
}


const DEFAULT_MOVE_VELOCITY: float = 3000.0


@export var health: float = 100.0
@export var damage: float = 1.0
@export var attack_type: AttackType

@export var movement_speed: float = DEFAULT_MOVE_VELOCITY
@export var target: Entity
@export var enemy : Node2D
@export var space: float = 50.0
@export var separation_force: float = 500.0

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var calc_timer: Timer = $calcTimer
@onready var animations = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var senses : Senses = $Senses

@export var melee_range : float = 20
@onready var cooldown : Timer = $Cooldown
var in_cooldown := false

var _local_entities = []
var team
var enable_navigation := false

#var right_cmd : Command
#var left_cmd : Command
#var up_cmd : Command
#var fire1 : Command
#var fire2 : Command
#var idle : Command

var facing:Facing = Facing.RIGHT

var attacking : bool: 
	set(value): 
		attacking = value
	get():
		return attacking

var walking : bool: 
	set(value): 
		walking = value
	get():
		return walking

var summoning : bool:
	set(value):
		summoning = value
	get():
		return summoning
		

#@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	attacking = false
	summoning = false
	change_facing(facing)
	
	calc_timer.timeout.connect(_on_timer_timeout)
	navigation_agent_2d.path_desired_distance = 4.0
	navigation_agent_2d.target_desired_distance = 50.0
	call_deferred("actor_setup")


func actor_setup() -> void:
	if target != null:
		await get_tree().physics_frame
		set_target_position(target.position)
	else:
		print("Target is not set!")
		return
	
#func new_wander_target(_radius : float = wander_radius):
	#var dir = Vector2(rand_range(min_x, max_x), rand_range(min_y, max_y))
	#set_target(dir + global_position)

func set_target_position(target_pos: Vector2) -> void:
	#print("target_pos: ", target_pos)
	navigation_agent_2d.target_position = target_pos


func _physics_process(delta: float) -> void: 
	_manage_animation_tree_state()
	if not enable_navigation:
		#print("finished")
		return
	_navigate(delta)
	

func _navigate(delta: float):
	if navigation_agent_2d.is_target_reached():
		toggle_navigation(false)
		return
		
	var cur_pos = global_position
	var next_pos = navigation_agent_2d.get_next_path_position()
	
	var direction = cur_pos.direction_to(next_pos)
	
	var separation = Vector2()
	for entity in _local_entities:
		var direction_away = cur_pos - entity.position
		var distance = cur_pos.distance_to(entity.position)
		if distance < space:
			separation += direction_away.normalized() / distance
			
	velocity = direction * movement_speed * delta
	if not _local_entities.is_empty():
		velocity += separation.normalized() * movement_speed * 0.8 * delta
	
	#print("locals: ", _local_entities)
	#print("velocity: ", velocity)
	_apply_movement(delta)
		
func _apply_movement(_delta: float):
	move_and_slide()
	#print(velocity.length())
	#print(velocity.length() > 5.0)
	#if velocity.length() > 5.0:
		#animations.play("walking")
	#else:
		#animations.play("attack")

func toggle_navigation(toggle : bool):
	enable_navigation = toggle
	if toggle == false:
		target = null
		navigation_agent_2d.target_position = global_position
		#nav_force = Vector3.ZERO
		#linear_velocity = Vector2.ZERO

func change_facing(new_facing: Facing) -> void:
	facing = new_facing
	#print(facing)
	emit_signal("CharacterDirectionChange", facing)

func face_target() -> void:
	var cur_pos = global_position
	var direction = cur_pos.direction_to(enemy.global_position)
	if direction.x < 0:
		#print("left")
		sprite.flip_h = false
		change_facing(Facing.LEFT)
	else:
		#print("right")
		sprite.flip_h = true
		change_facing(Facing.RIGHT)

func check_melee_range() -> bool:
	var cur_pos = global_position
	print(cur_pos.distance_to(enemy.global_position), " <= ", melee_range)
	return cur_pos.distance_to(enemy.global_position) <= melee_range


#This function is meant to be called in the AnimationController after the each relevant anmiation has concluded.
func clear_action_state() -> void:
	attacking = false
	summoning = false


func command_callback(_name:String) -> void:
	pass
	
func _on_timer_timeout() -> void:
	if target != null:
		set_target_position(target.position)
	else:
		return


#func _on_spacer_radius_body_entered(body: Node2D) -> void:
	#if body == self:
		#return
	#print("self: ", is_instance_of(self, Monster))
	#print("other: ", body is Monster)
	#if is_instance_of(self, Monster) and body is Monster:
		#_local_entities.push_back(body)
		#print("entered: ", _local_entities)
#
#
#func _on_spacer_radius_body_exited(body: Node2D) -> void:
	#_local_entities.erase(body)
	
func _manage_animation_tree_state() -> void:
	#print(animations.is_playing())
	if attacking:
		#nimation_tree["parameters/conditions/attack"] = true
		#print("attack: ", attacking)
		#print("playing: ",animations.is_playing())
		animations.play("attack")
		attacking = false
		#nimation_tree["parameters/conditions/attack"] = false
	elif walking:
		#print("walking")
		animations.play("walking")	
	#else:
		##animation_tree["parameters/conditions/walking"] = false
		#animations.play("idle")
	#if _damaged:
		#animation_tree["parameters/conditions/damaged"] = true
		#_damaged = false
	#else:
		#animation_tree["parameters/conditions/damaged"] = false
