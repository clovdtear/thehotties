# Shop.gd
extends Node2D

@export var customer_scene: PackedScene
@export var day_schedules: Array[DaySchedule] = []
var current_schedule: DaySchedule

func _ready() -> void:
	# Find the schedule for today
	for schedule in day_schedules:
		if schedule.day_number == GameManager.current_day:
			current_schedule = schedule
			break
	
	# Connect the clock signal
	GameManager.hour_passed.connect(_on_hour_passed)
	update_clock_ui()

func _on_hour_passed(hour: int) -> void:
	update_clock_ui()
	check_for_customers(hour)

func update_clock_ui() -> void:
	var display_hour = GameManager.current_hour
	var am_pm = "AM" if display_hour < 12 else "PM"
	if display_hour > 12:
		display_hour -= 12
	$UI/ClockLabel.text = str(display_hour) + ":00 " + am_pm

func check_for_customers(hour: int) -> void:
	if not current_schedule:
		return
		
	for event in current_schedule.events:
		if event.spawn_hour == hour:
			spawn_customer(event)

func spawn_customer(event: CustomerEvent) -> void:
	# 1. Instantiate the scene (preloaded exactly how you had it!)
	var customer_scene = preload("res://scenes/customer.tscn")
	var customer_instance = customer_scene.instantiate()
	add_child(customer_instance)
	
	# Optional: Position them in your shop
	customer_instance.global_position = Vector2(400, 300)
	
	# 2. Determine which dialogue to use based on past flags (your original logic)
	var dialogue_to_use = event.dialogue_tree
	for condition in event.conditional_dialogues:
		var needed_flag = condition.get("required_flag")
		if GameManager.get_flag(event.character_id, needed_flag) == true:
			dialogue_to_use = condition.get("dialogue_tree")
			break
			
	# 3. WEAVE IT IN HERE: Set up the visual look & order component first
	customer_instance.setup_customer(event, dialogue_to_use)
	
	# 4. Trigger the dialogue
	customer_instance.start_dialogue(event.character_id, dialogue_to_use)
