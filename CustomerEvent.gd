class_name CustomerEvent
extends Resource

@export var character_id : String = ""
@export var spawn_hour : int = 9

# Entire dialogue database for this character.
@export var dialogue_sets : Dictionary = {

	# Used only if the player has never met them.
"first_meeting": {
	"start": {
		"text": "Morning! Name's Student",
		"responses": [
			{
				"text":"Welcome! First visit?",
				"next":"friendly",
				"flag":"friendly"
			},
			{
				"text":"What can I get you?",
				"next":"neutral",
				"flag":"neutral"
			},
			{
				"text":"You're holding up the line.",
				"next":"rude",
				"flag":"rude"
			}
		]
	},

	"friendly":{
		"text":"Ha! I knew I'd like this place."
	},

	"neutral":{
		"text":"Coffee, black please."
	},

	"rude":{
		"text":"...Right."
	}
}
