extends Node2D
class_name Stage

@export_category("Stage Details")
@export var stage_name: String
@export var stage_end: int

@export_category("Components")
@export var border: Border
@export var exit: Exit
@export var player: Player
@export var stage_ui: StageUI

var min: int = 0
var sec: int = 0
var msec: int = 0

var time: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	border.set_border(stage_end)
	player.set_camera_limit(stage_end)
	
	stage_ui.set_stage_name(stage_name)
	
	time = Timer.new()
	time.wait_time = 0.01
	time.autostart = true
	add_child(time)
	time.timeout.connect(timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if msec == 100:
		sec += 1
		msec = 0
	if sec == 60:
		min += 1
		sec = 0
	
	var time = "%02d:%02d:%02d" % [min, sec, msec]
	stage_ui.set_time(time)

func timeout():
	msec += 1
