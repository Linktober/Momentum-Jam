class_name RunPhysics
extends GroundPhysics


@export var ground_name: String
@export var stop_buffer: float
var start_direction: int
var stop_timer: float


## runs this check every frame while active
## the string returned is the name of the state to change to
## return self.name for no change!
func _transition_check() -> String:
	var input_dir: int = 0
	if character.input["left"][0]: input_dir -= 1 
	if character.input["right"][0]: input_dir += 1
	
	if input_dir != start_direction:
		return ground_name
	
	if stop_timer > 0:
		return name
	
	return ground_check()


func ground_check() -> String:
	if not character.on_ground:
		return air_name
	return name


## runs once when this state begins being active
func _on_enter() -> void:
	stop_timer = stop_buffer


func _update(delta: float) -> void:
	if ground_check() != name:
		stop_timer -= delta
	else:
		stop_timer = stop_buffer
	
	super(delta)
