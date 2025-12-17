class_name Clover
extends Area2D


@onready var globals_id: String = get_path().get_concatenated_names()
@onready var color_rect: ColorRect = $ColorRect
@export var active_color: Color
@export var inactive_color: Color

var activated: bool = true


func _ready() -> void:
	if globals_id in Globals.collected_clovers:
		queue_free()
		return


func body_entered(body: Node2D) -> void:
	if not activated: return
	if not body is Character: return
	
	Globals.collected_clovers.append(globals_id)
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
