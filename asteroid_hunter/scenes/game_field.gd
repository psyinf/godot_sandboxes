extends Node

var half: Vector2

func set_size(size: Vector2) -> void:
	half = size / 2.0

func random_edge_position(margin: float = 0.0) -> Vector2:
	var side = randi_range(0, 3)
	var pos = Vector2.ZERO
	if side == 0:
		pos.x = -half.x - margin
		pos.y = randf_range(-half.y, half.y)
	elif side == 1:
		pos.x = half.x + margin
		pos.y = randf_range(-half.y, half.y)
	elif side == 2:
		pos.x = randf_range(-half.x, half.x)
		pos.y = -half.y - margin
	else:
		pos.x = randf_range(-half.x, half.x)
		pos.y = half.y + margin
	return pos

func clamp_position(pos: Vector2, margin: Vector2 = Vector2.ZERO) -> Vector2:
	return Vector2(
		clamp(pos.x, -half.x + margin.x, half.x - margin.x),
		clamp(pos.y, -half.y + margin.y, half.y - margin.y)
	)
