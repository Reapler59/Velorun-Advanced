extends Node2D
class_name Stage

@export_category("Stage Details")
@export var stage_end: int
@export var stage_cards: Array[Card]
@export var stage_id: int

@export_category("Components")
@export var border: Border
@export var exit: Exit
@export var player: Player
@export var stage_ui: StageUI

var stage_select = load("res://src/interfaces/stage_select.tscn")

var min: int = 0
var sec: int = 0
var msec: int = 0

var time: Timer
var has_reached_exit: bool = false

var level_name: String
var level_time: String
var level_cards: Array[bool]

# Called when the node enters the scene tree for the first time.
func _ready():
	border.set_border(stage_end)
	player.set_camera_limit(stage_end)
	
	level_name = DataManager.stages[stage_id].stage_name
	stage_ui.set_stage_name(level_name)
	
	time = Timer.new()
	time.wait_time = 0.01
	time.autostart = true
	add_child(time)
	time.timeout.connect(timeout)
	
	for i in 3:
		level_cards.append(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_cards()
	has_reached_exit = exit.reached_exit()
	
	if not has_reached_exit:
		if msec == 100:
			sec += 1
			msec = 0
		if sec == 60:
			min += 1
			sec = 0
		
		level_time = "%02d:%02d:%02d" % [min, sec, msec]
		stage_ui.set_time(level_time)
	else:
		var data = StageData.new()
		data.set_data(level_name, level_time, level_cards)
		DataManager.set_stage_data(stage_id, data)
		await get_tree().create_timer(1).timeout
		change_scene()
	
	if Input.is_action_just_pressed("pause"):
		change_scene()

func change_scene() -> void:
	get_tree().change_scene_to_packed(stage_select)

func handle_cards() -> void:
	for i in stage_cards.size():
		level_cards[i] = stage_cards[i].get_is_collected()


func timeout():
	msec += 1
