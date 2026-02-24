extends Node2D

func _ready() -> void:
	_update_field_size()
	get_tree().root.size_changed.connect(_update_field_size)

	var spawner = MeteorSpawner.new()
	spawner.name = "MeteorSpawner"
	add_child(spawner)

func _update_field_size() -> void:
	GameField.set_size(Vector2(get_tree().root.size))
