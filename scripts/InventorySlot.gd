extends Control

var item = null
var slot_index = -1

@onready var icon = $Icon


func set_item(new_item):
	item = new_item

	if item:
		icon.texture = item.icon
	else:
		icon.texture = null
