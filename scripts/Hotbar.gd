extends HBoxContainer


func _ready():

	for i in range(get_child_count()):

		var slot = get_child(i)

		slot.slot_index = i
		slot.slot_clicked.connect(_on_slot_clicked)

	update_hotbar()

func _on_slot_clicked(index):

	GameManager.selected_slot = index
	update_hotbar()

func update_hotbar():

	for i in range(get_child_count()):

		var slot = get_child(i)

		slot.set_item(GameManager.hotbar[i])

		slot.set_selected(i == GameManager.selected_slot)

	GameManager.selected_item = GameManager.hotbar[GameManager.selected_slot]
