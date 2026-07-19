extends PlaceSlot
class_name PlantSpot

@export var placed_pot_scene: PackedScene

var current_object: Node2D
var pot: ItemData = null
var dirt: ItemData = null
var planted_seed: ItemData = null


func can_accept(item: ItemData) -> bool:
	if pot == null:
		return item.id == "pot"

	if dirt == null:
		return item.id == "dirt"

	if seed == null:
		return item.id == "seed"

	return false


func place_item(item: ItemData):
	if pot == null:
		pot = item

		spawn_object(item)

		update_visual()

		return true


	if dirt == null:
		dirt = item

		update_visual()

		return true


	if planted_seed == null:
		planted_seed = item

		update_visual()

		return true

	return false


func spawn_object(item: ItemData):
	if placed_pot_scene == null:
		return

	current_object = placed_pot_scene.instantiate()

	add_child(current_object)

	current_object.setup(item)


func is_ready_to_grow() -> bool:
	return pot != null \
	and dirt != null \
	and seed != null


func update_visual():
	if pot == null:
		print("Show empty spot")

	elif dirt == null:
		print("Show pot")

	elif seed == null:
		print("Show pot with dirt")

	else:
		print("Show planted pot")
