extends Area2D
class_name ItemDropTarget


@export var target_name := ""


func _can_drop_data(_position, data):
	if data is DragData:
		return true

	return false



func _drop_data(_position, data):
	var stack = data.stack

	print(
		"Placed:",
		stack.item.item_name
	)

	GameManager.drag_data.clear()
