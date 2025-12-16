class_name GroundRotator
extends Rotator


@onready var left: RayCast2D = $Left
@onready var right: RayCast2D = $Right

@export var rot_speed: float = 10
var ground_offset: float = 0


func update_rotation(delta: float) -> float:
	## framerate independance
	var alpha: float = 1.0 - exp(-rot_speed * delta)
	
	if not left.is_colliding() or not right.is_colliding(): 
		return lerp_angle(animator.rotation, 0, alpha)
	
	var left_point: Vector2 = left.get_collision_point()
	var right_point: Vector2 = right.get_collision_point()
	var calculated_rotation: float = atan2(right_point.y - left_point.y, right_point.x - left_point.x)
	
	var target_offset: float = abs(calculated_rotation) * 10
	ground_offset = lerp(ground_offset, target_offset, alpha)
	animator.position.y += ground_offset
	
	return lerp_angle(animator.rotation, calculated_rotation / 2, alpha)
