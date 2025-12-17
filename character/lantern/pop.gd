extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var scale_speed: float
@export var scale_strength: float

var strength_factor: float
var pop_position: Vector2
var target_scale: Vector2


func _ready() -> void:
	get_parent().remove_child.call_deferred(self)
	get_owner().get_parent().add_child.call_deferred(self)


func pop(pop_pos: Vector2):
	pop_position = pop_pos
	scale = Vector2.ONE
	target_scale = Vector2.ONE * scale_strength * strength_factor
	animation_player.play("pop")


func _process(delta: float) -> void:
	global_position = pop_position
	
	## framerate independance
	var alpha: float = 1.0 - exp(-scale_speed * delta)
	scale = lerp(scale, target_scale, alpha)
