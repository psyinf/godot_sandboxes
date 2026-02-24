extends Sprite2D

const SPEED: int = 1000;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	

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
