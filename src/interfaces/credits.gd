extends Control

@onready var titlescreen = load("res://src/interfaces/titlescreen.tscn")
@onready var button_exit = $MarginContainer/ButtonExit

func _ready() -> void:
	button_exit.grab_focus()

func _process(delta) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_button_exit_pressed()

func _on_button_exit_pressed():
	get_tree().change_scene_to_packed(titlescreen)
