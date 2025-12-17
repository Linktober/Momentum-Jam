extends AnimatedSprite2D


@export_range(0, 90, 0.1, "radians_as_degrees") var max_rot: float
@export var rot_divide: float

@export var sine_amount: float
@export var sine_speed: float

@export var follow_speed: float
@export var lantern_target: LanternTarget
var last_global: Vector2


func _physics_process(delta: float) -> void:
	if lantern_target.instant_follow:
		global_position = lantern_target.global_position
		global_rotation = lantern_target.global_rotation
		last_global = global_position
		return
	
	## framerate independance
	var alpha: float = 1.0 - exp(-follow_speed * delta)
	
	rotation = lerp(rotation, 
		(lantern_target.global_position.x - global_position.x) / rot_divide * delta * max_rot, 
		alpha)
	
	var sine: float = sin(Time.get_unix_time_from_system() * sine_speed) * sine_amount
	
	global_position = last_global
	global_position = lerp(
		global_position, 
		lantern_target.global_position + Vector2(0, sine), 
		alpha
	)
	
	last_global = global_position
