extends Control

func _ready() -> void:
	#display the day that just ended (or the upcoming day)
	$DayLabel.text = "DAY " + str(GameManager.current_day)
	
	# You can add animations here, sum up shop profits, etc.

func _on_next_day_button_pressed() -> void:
	#Advance day and return to shop
	GameManager.start_new_day()
