extends CollectiblePlacer


@onready var spawner: Area2D = $Spawner
@onready var timer: Timer = $Timer
@export var clover: Clover

var collected_petals: Array[bool]


func _ready() -> void:
	if is_instance_valid(clover):
		clover.deactivate()
	collected_petals.resize(collectible_count)


func spawner_entered(body: Node2D) -> void:
	if not body is Character: return
	place()
	spawner.set_deferred("monitoring", false)
	spawner.hide()
	timer.start()


func collected(index: int) -> void:
	collected_petals[index] = true
	if collected_petals.count(false) <= 0:
		timer.stop()
		clover.activate()


func timeout() -> void:
	collected_petals.fill(false)
	for child in collectibles.get_children():
		child.queue_free()

	spawner.set_deferred("monitoring", true)
	spawner.show()
