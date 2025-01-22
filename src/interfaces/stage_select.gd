extends Control

@onready var titlescreen = load("res://src/interfaces/titlescreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_on_button_exit_pressed()


func _on_button_exit_pressed():
	get_tree().change_scene_to_packed(titlescreen)
