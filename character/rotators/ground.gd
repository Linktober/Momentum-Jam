class_name GroundRotator
extends Rotator


@onready var left: RayCast2D = $Left
@onready var right: RayCast2D = $Right

@export var rot_speed: float = 10
var ground_offset: float = 0


func update_rotation(delta: float) -> float:
	if not left.is_colliding() and right.is_colliding(): 
		return animator.rotation
	
	var front_point: Vector2 = left.get_collision_point()
	var back_point: Vector2 = right.get_collision_point()
	var calculated_rotation: float = atan2(back_point.y - front_point.y, back_point.x - front_point.x)
	 
	## framerate independance
	var alpha: float = 1.0 - exp(-rot_speed * delta)
	
	var target_offset: float = abs(
		front_point.y + back_point.y - animator.global_position.y * 2) / 2
	ground_offset = lerp(ground_offset, target_offset, alpha)
	animator.position.y += ground_offset
	
	return lerp_angle(animator.rotation, calculated_rotation / 2, alpha)
