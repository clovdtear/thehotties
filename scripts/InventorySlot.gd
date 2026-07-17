extends Control

signal slot_clicked(slot_index)

var item = null
var slot_index = -1

@onready var icon = $Icon
@onready var background = $Background

func set_item(new_item):
	item = new_item

	if item:
		icon.texture = item.icon
	else:
		icon.texture = null

func set_selected(selected: bool):

	if selected:
		background.modulate = Color(1, 1, 0.5)
	else:
		background.modulate = Color.WHITE

func _gui_input(event):

	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:

		slot_clicked.emit(slot_index)
