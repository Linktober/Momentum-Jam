class_name AirRotator
extends Rotator


@export var rot_speed: float = 10


func update_rotation(delta: float) -> float:
	## framerate independance
	var alpha: float = 1.0 - exp(-rot_speed * delta)
	return lerp_angle(animator.rotation, 0, alpha)
