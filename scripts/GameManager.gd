extends Node

var hotbar = [
	preload("res://resources/items/pot.tres"),
	preload("res://resources/items/dirt.tres"),
	preload("res://resources/items/seed.tres"),
	null,
	null,
	null,
	null
]

var storage = [
	null, null, null, null, null,
	null, null, null, null, null,
	null, null, null, null, null
]

var selected_slot = 0
var selected_item = null
