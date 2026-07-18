extends CharacterBody2D 


@onready var sprite: Sprite2D = $Sprite2D
@onready var order_component: Node = $OrderComponent 

#Hold the data for whoever this customer is today
var character_id: String
var current_dialogue: Dictionary

func setup_customer(event_data: CustomerEvent) -> void:
	character_id = event_data.character_id
	
	# 1. Load the correct visual sprite for this character dynamically
	# (Assumes you name your textures "Bob.png", "Alice.png", etc.)
	var path = "res://art/characters/" + character_id + ".png"
	if ResourceLoader.exists(path):
		sprite.texture = load(path)
		
	# 2. Assign their dialogue tree
	current_dialogue = event_data.dialogue_tree
	
	# 3. Trigger your order script using this event's data
	# (You can pass the customer ID or specific order items here)
	order_component.assign_order_items(character_id)

func start_speaking() -> void:
	#code to open dialogue bubble and show current_dialogue...
	pass
	
	
