#GameManager.gd (Autoload Singleton)
extends Node

signal hour_passed(current_hour: int)
signal day_ended

var current_day: int = 1
var current_hour: int = 8  # Start at 8 AM
var game_speed: float = 1.0 # Real seconds per game-hour

#store player choices:{"character_name": {"choice_key": "choice_value"}}
var story_flags: Dictionary = {}

var time_elapsed: float = 0.0
var is_shop_open: bool = true

func _process(delta: float) -> void:
	if is_shop_open:
		time_elapsed += delta
		if time_elapsed >= game_speed:
			time_elapsed = 0.0
			advance_hour()

func advance_hour() -> void:
	current_hour += 1
	hour_passed.emit(current_hour)
	
	if current_hour >= 18: # 6 PM
		end_day()

func end_day() -> void:
	is_shop_open = false
	day_ended.emit()
	get_tree().change_scene_to_file(" ")#day 0 day 1 ... (shold display from start game)

func start_new_day() -> void:
	current_day += 1
	current_hour = 8
	time_elapsed = 0.0
	is_shop_open = true
	get_tree().change_scene_to_file("res://scenes/walls/main_room.tscn")

#Helper to save dialogue choices
func set_flag(character: String, flag_name: String, value: Variant) -> void:
	if not story_flags.has(character):
		story_flags[character] = {}
	story_flags[character][flag_name] = value

func get_flag(character: String, flag_name: String, default: Variant = null) -> Variant:
	if story_flags.has(character) and story_flags[character].has(flag_name):
		return story_flags[character][flag_name]
	return default
