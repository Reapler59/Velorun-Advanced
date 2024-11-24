extends CanvasLayer
class_name StageUI

@onready var stage_name = $MarginContainer/VBoxContainer/StageName
@onready var time = $MarginContainer/VBoxContainer/Time

func set_stage_name(content: String) -> void:
	stage_name.text = content

func set_time(content: String) -> void:
	time.text = content
