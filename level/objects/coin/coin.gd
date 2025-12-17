class_name Collectible
extends Area2D


@export var magnet_speed: float

var character: Character
var is_collected: bool
var placed_index: int

signal collected(placed_index: int)


func body_entered(body: Node2D) -> void:
	if body is Character and not is_collected:
		character = body


func body_exited(body: Node2D) -> void:
	if body == character:
		character = null


func _physics_process(delta: float) -> void:
	if not is_instance_valid(character): return
	
	## framerate independance
	var alpha: float = 1.0 - exp(-magnet_speed * delta)
	global_position = global_position.lerp(character.global_position, alpha)


func collect_body_entered(body: Node2D) -> void:
	if body is Character:
		queue_free()
		is_collected = true
		emit_signal("collected", placed_index)
		character = null
