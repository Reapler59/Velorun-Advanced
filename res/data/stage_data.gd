extends Resource
class_name StageData

@export var stage_name: String = "Stage Name"
@export var time: String = "00:00:00"
@export var has_cards: Array = [false, false, false]


func set_data(name: String, value: String, cards: Array):
	stage_name = name
	time = value
	
	if cards[0] == true:
		has_cards[0] = true
	if cards[1] == true:
		has_cards[1] = true
	if cards[2] == true:
		has_cards[2] = true
