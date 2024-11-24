extends Control

@onready var stage_name_label = $MarginContainer/PanelContainer/VBoxContainer/StageName
@onready var time_label = $MarginContainer/PanelContainer/VBoxContainer/Time
@onready var card_icon_1 = $MarginContainer/PanelContainer/VBoxContainer/HBoxContainer/Card1
@onready var card_icon_2 = $MarginContainer/PanelContainer/VBoxContainer/HBoxContainer/Card2
@onready var card_icon_3 = $MarginContainer/PanelContainer/VBoxContainer/HBoxContainer/Card3
@onready var button_play = $MarginContainer/PanelContainer/VBoxContainer/ButtonPlay

@onready var slot_empty = load("res://assets/sprites/ui/card_slot.png")
@onready var slot_filled = load("res://assets/sprites/ui/card_slot_full.png")

@export var id: int = 0
@export var stage: PackedScene

var data: StageData

# Called when the node enters the scene tree for the first time.
func _ready():
	data = DataManager.get_stage_data(id)
	stage_name_label.text = data.stage_name
	time_label.text = data.time
	
	handle_icons()
	
	button_play.grab_focus()

func handle_icons() -> void:
	if data.has_cards[0] == false:
		card_icon_1.texture = slot_empty
	else:
		card_icon_1.texture = slot_filled
	
	if data.has_cards[1] == false:
		card_icon_2.texture = slot_empty
	else:
		card_icon_2.texture = slot_filled
	
	if data.has_cards[2] == false:
		card_icon_3.texture = slot_empty
	else:
		card_icon_3.texture = slot_filled


func _on_button_play_pressed():
	get_tree().change_scene_to_packed(stage)
