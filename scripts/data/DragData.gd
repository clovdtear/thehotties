extends RefCounted
class_name DragData


var stack: ItemStack = null
var inventory_type := ""
var slot_index := -1


func clear():

	stack = null
	inventory_type = ""
	slot_index = -1


func get_item_name():

	if stack:
		return stack.item.item_name

	return ""


func is_dragging() -> bool:

	return stack != null
