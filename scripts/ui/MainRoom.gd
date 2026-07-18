extends Node2D


@onready var storage = $UI/StorageInventory


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if storage.visible:
			storage.visible = false
		else:
			storage.visible = true
			storage.update_storage()

	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_RIGHT \
	and event.pressed:
		GameManager.drag_data.clear()


var walls = [
	preload("res://scenes/walls/wall_front.tscn"),
	preload("res://scenes/walls/wall_right.tscn"),
	preload("res://scenes/walls/wall_back.tscn"),
	preload("res://scenes/walls/wall_left.tscn")
]


var current_wall = 0
var wall_instance


func _ready():
	change_wall(current_wall)
	
	for stack in GameManager.hotbar.slots:

		if stack:

			print(
				stack.item.item_name,
				"x",
				stack.amount
			)


func change_wall(number):
	if wall_instance:
		wall_instance.queue_free()

	current_wall = number
	wall_instance = walls[current_wall].instantiate()
	$WallContainer.add_child(wall_instance)


func _on_left_arrow_pressed() -> void:
	var next_wall = current_wall - 1

	if next_wall < 0:
		next_wall = walls.size() - 1

	change_wall(next_wall)


func _on_right_arrow_pressed() -> void:
	var next_wall = current_wall + 1

	if next_wall >= walls.size():
		next_wall = 0

	change_wall(next_wall)
