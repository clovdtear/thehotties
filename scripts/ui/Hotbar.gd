extends HBoxContainer


func _ready():

	GameManager.inventory_changed.connect(update_hotbar)

	var index := 0

	for child in get_children():

		if child is InventorySlot:

			child.inventory_type = "hotbar"
			child.slot_index = index

			index += 1


	update_hotbar()


func update_hotbar():

	var index := 0

	for child in get_children():

		if child is InventorySlot:

			child.set_stack(
				GameManager.hotbar.get_slot(index)
			)

			index += 1
