extends Control

@onready var background = $Background
@onready var button_play = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ButtonPlay
@onready var button_credits = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ButtonCredits
@onready var button_exit = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ButtonExit
@onready var button_options: Button = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ButtonOptions

@onready var stage_select = load("res://src/interfaces/stage_select.tscn")
@onready var credits = load("res://src/interfaces/credits.tscn")
@onready var settings = load("res://src/interfaces/settings.tscn")

func _init():
	DataManager.load_data()

# Called when the node enters the scene tree for the first time.
func _ready():
	button_exit.grab_focus()
	button_credits.grab_focus()
	button_play.grab_focus()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


#region signals
# Button Pressed
func _on_button_play_pressed():
	get_tree().change_scene_to_packed(stage_select)

func _on_button_credits_pressed():
	get_tree().change_scene_to_packed(credits)
	
func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_packed(settings)

func _on_button_exit_pressed():
	get_tree().quit()

# Mouse Hover
func _on_button_play_mouse_entered():
	button_play.grab_focus()

func _on_button_credits_mouse_entered():
	button_credits.grab_focus()

func _on_button_exit_mouse_entered():
	button_exit.grab_focus()

func _on_button_options_mouse_entered() -> void:
	button_options.grab_focus()
#endregion
