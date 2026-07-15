extends HBoxContainer


func _ready():
	update_hotbar()


func update_hotbar():

	for i in range(7):

		var slot = get_child(i)

		var item = GameManager.inventory[i]

		slot.set_item(item)
