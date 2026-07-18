extends Panel


@onready var grid = $GridContainer


func _ready():
	GameManager.inventory_changed.connect(update_storage)

	visible = false

	for i in range(grid.get_child_count()):
		var slot = grid.get_child(i)

		slot.inventory_type = "storage"
		slot.slot_index = i

	update_storage()


func update_storage():

	for i in range(grid.get_child_count()):

		var slot = grid.get_child(i)

		slot.slot_index = i

		slot.set_stack(
			GameManager.storage.get_slot(i)
		)
