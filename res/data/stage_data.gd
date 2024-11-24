extends Resource
class_name StageData

@export var stage_name: String = "Stage Name"
@export var time: String = "00:00:00"
@export var has_cards: Array[bool] = [false, false, false]


func set_data(name: String, value: String, cards: Array[bool]):
	stage_name = name
	time = value
	has_cards = cards
