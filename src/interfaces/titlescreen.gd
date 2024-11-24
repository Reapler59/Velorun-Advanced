extends Control

@onready var background = $Background
@onready var button_play = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ButtonPlay
@onready var button_options = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ButtonOptions
@onready var button_credits = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ButtonCredits
@onready var button_exit = $MarginContainer/VBoxContainer/PanelContainer/VBoxContainer/ButtonExit

# Called when the node enters the scene tree for the first time.
func _ready():
	button_exit.grab_focus()
	button_credits.grab_focus()
	button_options.grab_focus()
	button_play.grab_focus()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.scroll_offset.x -= 160 * delta


#region signals
# Button Pressed
func _on_button_play_pressed():
	pass # Replace with function body.

func _on_button_options_pressed():
	pass # Replace with function body.

func _on_button_credits_pressed():
	pass # Replace with function body.

func _on_button_exit_pressed():
	get_tree().quit()

# Mouse Hover
func _on_button_play_mouse_entered():
	button_play.grab_focus()

func _on_button_options_mouse_entered():
	button_options.grab_focus()

func _on_button_credits_mouse_entered():
	button_credits.grab_focus()

func _on_button_exit_mouse_entered():
	button_exit.grab_focus()
#endregion
