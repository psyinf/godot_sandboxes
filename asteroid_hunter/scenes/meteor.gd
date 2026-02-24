extends Area2D

var speed: float = 0.0
var rotation_speed: float = 0.0
var direction: Vector2 = Vector2.DOWN

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func configure(spawn_position: Vector2, spawn_direction: Vector2, new_speed: float, new_rotation_speed: float) -> void:
	global_position = spawn_position
	direction = spawn_direction.normalized()
	speed = new_speed
	rotation_speed = new_rotation_speed

func _ready() -> void:
	add_to_group("meteors")

	if sprite.texture != null:
		var tex_size = sprite.texture.get_size()
		if collision_shape.shape is RectangleShape2D:
			collision_shape.shape.size = tex_size

	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	global_position += direction * speed * delta
	rotation += rotation_speed * delta

func _on_body_entered(_body: Node) -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	queue_free()
