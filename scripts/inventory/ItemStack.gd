extends RefCounted
class_name ItemStack


var item: ItemData
var amount: int = 1


func _init(new_item: ItemData, new_amount := 1):
	item = new_item
	amount = new_amount


func is_empty() -> bool:
	return item == null or amount <= 0


func add_amount(value: int):
	amount += value


func remove_amount(value: int):
	amount -= value

	if amount < 0:
		amount = 0


func can_merge(other: ItemStack) -> bool:
	if other == null:
		return false

	return item.id == other.item.id


func merge(other: ItemStack):
	amount += other.amount

	other.amount = 0
	other.item = null
