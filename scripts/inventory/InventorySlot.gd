extends Control
class_name InventorySlot


var inventory_type := ""
var slot_index := -1
var stack: ItemStack = null


@onready var icon = $Icon


func set_stack(new_stack):
	stack = new_stack

	if stack:
		icon.texture = stack.item.icon
	else:
		icon.texture = null


func _get_drag_data(_position):
	if stack == null:
		return null

	# Store what we are dragging
	GameManager.drag_data.stack = stack
	GameManager.drag_data.inventory_type = inventory_type
	GameManager.drag_data.slot_index = slot_index

	# Create drag preview
	var preview = TextureRect.new()

	preview.texture = stack.item.icon
	preview.custom_minimum_size = Vector2(64,64)
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE

	set_drag_preview(preview)

	return GameManager.drag_data


func _drop_data(_position, data):
	var from_inventory = GameManager.get_inventory(
		data.inventory_type
	)

	var to_inventory = GameManager.get_inventory(
		inventory_type
	)

	var dragged_stack = from_inventory.get_slot(
		data.slot_index
	)

	var target_stack = to_inventory.get_slot(
		slot_index
	)

	# Same item? Merge
	if target_stack and dragged_stack.can_merge(target_stack):
		target_stack.merge(dragged_stack)

		from_inventory.set_slot(
			data.slot_index,
			null
		)

	# Empty slot? Move
	elif target_stack == null:
		to_inventory.set_slot(
			slot_index,
			dragged_stack
		)

		from_inventory.set_slot(
			data.slot_index,
			null
		)

	# Different item? Swap
	else:
		from_inventory.swap_slots(
			data.slot_index,
			to_inventory,
			slot_index
		)

	GameManager.drag_data.clear()

	GameManager.inventory_changed.emit()


func _can_drop_data(_position, data):
	if data is DragData:
		return true

	return false


func refresh_inventory_ui():
	var parent = get_parent().get_parent()

	if parent.has_method("update_hotbar"):
		parent.update_hotbar()

	if parent.has_method("update_storage"):
		parent.update_storage()
