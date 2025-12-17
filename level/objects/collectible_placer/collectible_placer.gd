class_name CollectiblePlacer
extends Path2D


@onready var globals_id: String = get_path().get_concatenated_names()
@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@onready var collectibles: Node2D = $Collectibles

@export var collectible_scene: PackedScene
@export var collectible_count: int

@export var place_on_ready: bool = true


func _ready() -> void:
	if place_on_ready:
		place()


func collected(index: int) -> void:
	var collected_array: PackedByteArray = Globals.collected_coins.get(globals_id, [])
	collected_array.append(index)
	Globals.collected_coins.set(globals_id, collected_array)


func place() -> void:
	for i: float in range(collectible_count):
		path_follow_2d.progress_ratio = (i + 1) / collectible_count
		
		if not i in Globals.collected_coins.get(globals_id, []):
			var collectible: Node2D = collectible_scene.instantiate()
			collectible.global_position = path_follow_2d.global_position - global_position
			collectible.placed_index = i
			collectible.connect("collected", collected)
			collectibles.add_child.call_deferred(collectible)
