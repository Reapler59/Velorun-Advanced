extends Resource
class_name StageData

@export var stage_name: String = "Stage Name"
@export var time: String = "00:00:00"
@export var has_cards: Array = [false, false, false]


func set_data(name: String, value: String, cards: Array):
	stage_name = name
	time = compare_time_strings(time, value)
	
	if cards[0] == true:
		has_cards[0] = true
	if cards[1] == true:
		has_cards[1] = true
	if cards[2] == true:
		has_cards[2] = true

func time_string_conversion(value: String):
	var parts = value.split(":")
	if parts.size() != 3:
		return -1 # invalid format
	
	var min = int(parts[0])
	var sec = int(parts[1])
	var hsec = int(parts[2])
	
	var total = (min * 60 * 100) + (sec * 100) + hsec
	return total

func compare_time_strings(value1: String, value2: String):
	if value1 == "00:00:00":
		return value2
	elif value2 == "00:00:00":
		return value1
	
	if time_string_conversion(value1) <= time_string_conversion(value2):
		return value1
	else:
		return value2
