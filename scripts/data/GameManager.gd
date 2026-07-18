extends Node


signal inventory_changed


var pot = preload("res://resources/items/pot.tres")
var dirt = preload("res://resources/items/dirt.tres")
var seed_item = preload("res://resources/items/seed.tres")


var hotbar: Inventory
var storage: Inventory
var drag_data := DragData.new()


func _ready():
	hotbar = Inventory.new(7)
	storage = Inventory.new(15)

	hotbar.set_slot(
		0,
		ItemStack.new(pot,1)
	)

	hotbar.set_slot(
		1,
		ItemStack.new(dirt,15)
	)

	hotbar.set_slot(
		2,
		ItemStack.new(seed_item,8)
	)
	
	hotbar.set_slot(
		3,
		ItemStack.new(seed_item,8)
	)


func get_inventory(type: String) -> Inventory:
	match type:
		"hotbar":
			return hotbar
		"storage":
			return storage

	return null
