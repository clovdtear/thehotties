extends Node2D

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
	
	for item in GameManager.inventory:
		if item:
			print(item.item_name)

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
