extends Node2D
class_name  Border

@onready var border = $Right

func set_border(position_x: int) -> void:
	border.position.x = position_x
