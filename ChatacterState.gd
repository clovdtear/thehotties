class_name CharacterState
extends Resource

@export var met : bool = false
@export var relationship : int = 0

@export var last_mood : String = ""

@export var times_spoken : int = 0

@export var last_day_seen : int = -1

@export var flags : Array[String] = []


func get_dialogue(customer:CustomerEvent, state:CharacterState):

	if !state.met:
		return customer.dialogue_sets["first_meeting"]

	match state.last_mood:

		"friendly":
			if customer.dialogue_sets.has("friendly_return"):
				return customer.dialogue_sets["friendly_return"]

		"rude":
			if customer.dialogue_sets.has("rude_return"):
				return customer.dialogue_sets["rude_return"]

	return customer.dialogue_sets["default"]
