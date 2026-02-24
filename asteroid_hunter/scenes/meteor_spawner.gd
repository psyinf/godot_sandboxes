extends Node

class_name MeteorSpawner

@export var spawn_interval_min: float = 0.8
@export var spawn_interval_max: float = 2.0
@export var speed_min: float = 120.0
@export var speed_max: float = 260.0
@export var rotation_speed_min: float = -2.5
@export var rotation_speed_max: float = 2.5

var spawn_timer: float = 0.0
var meteor_scene: PackedScene = preload("res://scenes/meteor.tscn")

func _ready() -> void:
	randomize()
	_spawn_next()

func _process(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		_spawn_meteor()
		_spawn_next()

func _spawn_meteor() -> void:
	var player = get_tree().current_scene.get_node_or_null("Player")
	if player == null:
		push_warning("MeteorSpawner: could not find Player node")
		return
	var meteor = meteor_scene.instantiate()
	var tex_size = Vector2(120, 120)
	var sprite = meteor.get_node_or_null("Sprite2D")
	if sprite != null and sprite.texture != null:
		tex_size = sprite.texture.get_size()
	var margin = max(tex_size.x, tex_size.y) / 2.0
	var spawn_pos = Vector2(randf_range(-GameField.half.x, GameField.half.x), -GameField.half.y - margin)
	var direction = (player.global_position - spawn_pos).normalized()
	var speed = randf_range(speed_min, speed_max)
	var rot_speed = randf_range(rotation_speed_min, rotation_speed_max)
	get_tree().current_scene.add_child(meteor)
	meteor.configure(spawn_pos, direction, speed, rot_speed)

func _spawn_next() -> void:
	spawn_timer = randf_range(spawn_interval_min, spawn_interval_max)
