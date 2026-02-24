extends Area2D

@export var speed: float = 1500.0
var direction: Vector2 = Vector2.UP

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func configure(new_direction: Vector2) -> void:
	direction = new_direction.normalized()

func _ready() -> void:
	if sprite.texture != null:
		var tex_size = sprite.texture.get_size()
		if collision_shape.shape is RectangleShape2D:
			collision_shape.shape.size = tex_size

	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	global_position += direction * speed * delta
	_free_if_offscreen()

func _free_if_offscreen() -> void:
	var viewport_rect = get_viewport_rect()
	var half = viewport_rect.size / 2
	var margin = 200.0

	if global_position.x < -half.x - margin:
		queue_free()
		return
	if global_position.x > half.x + margin:
		queue_free()
		return
	if global_position.y < -half.y - margin:
		queue_free()
		return
	if global_position.y > half.y + margin:
		queue_free()

func _on_body_entered(_body: Node) -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	queue_free()
