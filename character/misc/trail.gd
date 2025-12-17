extends AnimatedSprite2D


@onready var parent: AnimatedSprite2D = get_parent()


func _process(_delta: float) -> void:
	animation = parent.animation
	frame = parent.frame
	flip_h = parent.flip_h
	flip_v = parent.flip_v
