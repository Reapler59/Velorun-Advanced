extends Node2D
class_name Card

@onready var sprite = $Sprite2D
@onready var collision = $Area2D/CollisionShape2D
@onready var animation = $AnimationPlayer

@export var id: int

var is_collected: bool = false

func _ready() -> void:
	animation.play("idle")

func get_is_collected() -> bool:
	return is_collected


func _on_detection_body_entered(body):
	sprite.call_deferred("set", "visible", false)
	collision.call_deferred("set", "disabled", true)
	is_collected = true
