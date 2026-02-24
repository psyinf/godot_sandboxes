extends Sprite2D

const SPEED: int = 1000;
const FIRE_COOLDOWN: float = 0.15

var fire_timer: float = 0.0
var projectile_scene: PackedScene = preload("res://scenes/projectile.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var area = $Area2D
	area.area_entered.connect(_on_area_entered)
	area.body_entered.connect(_on_body_entered)

func _on_area_entered(area: Area2D) -> void:
	# TODO: add broad-phase (large circle) + fine-phase (tight convex polygon) two-stage collision
	print("Player hit by area: ", area.name)

func _on_body_entered(body: Node) -> void:
	print("Player hit by body: ", body.name)

func _clampToScreen() -> void:
	var half_size = texture.get_size() / 2
	half_size.x *= 0.5
	position = GameField.clamp_position(position, half_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#process inputs
	if Input.is_action_pressed("player_right"):	
		position.x += SPEED * delta
	if Input.is_action_pressed("player_left"):
		position.x -= SPEED * delta	
	if Input.is_action_pressed("player_down"):
		position.y += SPEED * delta
	if Input.is_action_pressed("player_up"):
		position.y -= SPEED * delta
	
	# Restrict movement to scene bounds
	_clampToScreen();

	_handle_fire(delta)

func _handle_fire(delta: float) -> void:
	if fire_timer > 0.0:
		fire_timer -= delta

	if Input.is_action_pressed("player_fire_laser") and fire_timer <= 0.0:
		_fire()
		fire_timer = FIRE_COOLDOWN

func _fire() -> void:
	var projectile = projectile_scene.instantiate()
	var spawn_offset = Vector2(0, -texture.get_size().y * 0.6)
	projectile.global_position = global_position + spawn_offset
	if projectile.has_method("configure"):
		projectile.configure(Vector2.UP)

	get_tree().current_scene.add_child(projectile)
		
		
