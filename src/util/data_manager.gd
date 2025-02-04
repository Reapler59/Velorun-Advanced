extends Node

var stages: Dictionary = {
	0: StageData.new(),
	1: StageData.new(),
	2: StageData.new(),
	3: StageData.new()
}

var fullscreen: bool = false
var resolution: int = 2

func _ready() -> void:
	stages[0].stage_name = "Stage 0"
	stages[1].stage_name = "Stage 1"
	stages[2].stage_name = "Stage 2"
	stages[3].stage_name = "Stage 3"

func set_stage_data(id: int, data: StageData):
	stages[id] = data

func get_stage_data(id: int) -> StageData:
	return stages[id]

func reset_data() -> void:
	for i in stages:
		stages[i] = StageData.new()
		stages[i].stage_name = "Stage " + str(i)

func update_settings() -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	match resolution:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))

var save_path ="user://savegame.cfg"
var config = ConfigFile.new()

func save_data() -> void:
	for i in stages:
		config.set_value("stages","stage" + str(i),stages[i])
	config.set_value("settings","fullscreen",fullscreen)
	config.set_value("settings","resolution",resolution)
	config.save(save_path)

func load_data():
	var err = config.load(save_path)
	if err == OK:
		for i in stages:
			stages[i] = config.get_value("stages","stage" + str(i))
		fullscreen = config.get_value("settings","fullscreen")
		resolution = config.get_value("settings","resolution")
