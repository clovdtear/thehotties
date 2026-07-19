extends Control
class_name PlaceSlot


signal item_placed(item)


var placed_item: ItemData = null


func _can_drop_data(_position, data):
	return data is DragData


func _drop_data(_position, data):
	var stack = data.stack

	if stack == null:
		return

	if !can_accept(stack.item):
		return

	if place_item(stack.item):

		var inventory = GameManager.get_inventory(
			data.inventory_type
		)

		inventory.remove_one(data.slot_index)

		GameManager.drag_data.clear()

		GameManager.inventory_changed.emit()


func can_accept(_item: ItemData) -> bool:
	return placed_item == null


func place_item(item: ItemData):
	placed_item = item

	item_placed.emit(item)

	return true
