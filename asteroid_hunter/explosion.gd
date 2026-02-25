extends Node2D

func _ready() -> void:
	var anim: AnimatedSprite2D = $AnimatedSprite2D
	anim.sprite_frames.set_animation_loop("default", false)
	anim.animation_finished.connect(queue_free)
	anim.play("default")
