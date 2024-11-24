extends Node2D
class_name Exit

@onready var sprite = $Sprite2D
@onready var collision = $StaticBody2D/CollisionShape2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var has_reached_exit: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	sprite.frame = 5

func _on_detection_body_entered(body: Node2D) -> void:
	animation.play("close")
	has_reached_exit = true

func _on_animation_finished(anim_name):
	collision.call_deferred("set", "disabled", false)

func reached_exit() -> bool:
	return has_reached_exit
