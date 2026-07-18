class_name student
extends Resource
#0,1,3,7,11,12
@export var character_id : String = "Student"
@export var spawn_hour : int = 9

class_name CustomerEvent
extends Resource

@export var character_id := "Student"

@export var conversations := {

	"intro_day0": { },

	"intro_day1": { },

	"checkin_day1": { },

	"day3": { },

	"day7_good": { },

	"day7_bad": { },

	"day11_good": { },

	"day11_bad": { },

	"ending_good": { },

	"ending_neutral": { },

	"ending_bad": { }

}
