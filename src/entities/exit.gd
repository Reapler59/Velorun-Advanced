extends Node2D
class_name Exit

@onready var sprite = $Sprite2D
@onready var collision = $StaticBody2D/CollisionShape2D
@onready var animation: AnimationPlayer = $AnimationPlayer

signal exit_reached

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	sprite.frame = 5

func _on_detection_body_entered(body: Node2D) -> void:
	animation.play("close")

func _on_animation_finished(anim_name):
	collision.call_deferred("set", "disabled", false)
	exit_reached.emit()
