class_name Clover
extends Area2D


@onready var color_rect: ColorRect = $ColorRect
@export var active_color: Color
@export var inactive_color: Color

var activated: bool = true


func body_entered(body: Node2D) -> void:
	if not activated: return
	if not body is Character: return
	
	var character: Character = body
	var collect_physics: CollectPhysics = character.get_node("%Collect")
	collect_physics.target_x = global_position.x
	character.set_state("physics", collect_physics)
	queue_free()


func deactivate() -> void:
	activated = false
	color_rect.color = inactive_color


func activate() -> void:
	color_rect.color = active_color
	activated = true
