extends RefCounted
class_name Inventory


var slots: Array


func _init(size: int):
	slots.resize(size)


func get_slot(index: int):
	if index < 0 or index >= slots.size():
		return null

	return slots[index]


func set_slot(index: int, stack: ItemStack):
	slots[index] = stack


func swap_slots(index_a: int, other: Inventory, index_b: int):
	var temp = slots[index_a]

	slots[index_a] = other.slots[index_b]

	other.slots[index_b] = temp


func remove_one(index: int):
	var stack = slots[index]

	if stack == null:
		return

	stack.remove_amount(1)

	if stack.is_empty():
		slots[index] = null
