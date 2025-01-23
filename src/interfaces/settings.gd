extends Control

@onready var titlescreen = load("res://src/interfaces/titlescreen.tscn")
@onready var fullscreen: CheckBox = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Fullscreen/CheckBox
@onready var resolution: OptionButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Resolution/OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	fullscreen.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_on_button_exit_pressed()


func _on_button_exit_pressed() -> void:
	get_tree().change_scene_to_packed(titlescreen)

func _on_button_reset_pressed() -> void:
	DataManager.reset_data()


func _on_check_box_toggled(toggled_on: bool) -> void:
	DataManager.fullscreen = fullscreen.button_pressed
	DataManager.update_settings()

func _on_option_button_item_selected(index: int) -> void:
	DataManager.resolution = index
	DataManager.update_settings()
