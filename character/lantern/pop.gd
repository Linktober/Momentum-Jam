extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var scale_speed: float
@export var scale_strength: float

var character: Character

var strength_factor: float
var pop_position: Vector2
var target_scale: Vector2
var tree_exit_known: bool = false


func _enter_tree() -> void:
	if not is_instance_valid(character) or get_parent() == character:
		character = get_parent()
		character.remove_child.call_deferred(self)
		character.get_parent().add_child.call_deferred(self)
		tree_exit_known = true


func _exit_tree() -> void:
	if tree_exit_known:
		tree_exit_known = false
		return
	
	get_parent().remove_child.call_deferred(self)
	character.add_child.call_deferred(self)


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
