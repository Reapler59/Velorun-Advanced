extends Node

var stages: Dictionary = {
	0: StageData.new(),
	1: StageData.new(),
	2: StageData.new(),
	3: StageData.new()
}

func _ready() -> void:
	stages[0].stage_name = "Stage 0"
	stages[1].stage_name = "Stage 1"
	stages[2].stage_name = "Stage 2"
	stages[3].stage_name = "Stage 3"

func set_stage_data(id: int, data: StageData):
	stages[id] = data

func get_stage_data(id: int) -> StageData:
	return stages[id]
