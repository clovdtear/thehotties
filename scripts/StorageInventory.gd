extends Panel

@onready var grid = $GridContainer

func _ready():

	visible = false

	for i in range(grid.get_child_count()):

		var slot = grid.get_child(i)

		slot.slot_index = i
		slot.slot_clicked.connect(_on_slot_clicked)

	update_storage()

func _on_slot_clicked(index):

	print("Storage slot:", index)

func update_storage():

	for i in range(grid.get_child_count()):

		var slot = grid.get_child(i)

		slot.slot_index = i

		slot.set_item(GameManager.storage[i])
