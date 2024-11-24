extends StaticBody2D

@onready var animation = $AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D


@export var cooldown := 1.0
@export var is_up : bool = true

var cooldown_timer : Timer


# Called when the node enters the scene tree for the first time.
func _ready():	
	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)
	cooldown_timer.timeout.connect(cooldown_timeout)
	
	if not is_up:
		sprite.frame = 4
	
	cooldown_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_up:
		collision.disabled = false
	else:
		collision.disabled = true


func cooldown_timeout():
	if is_up:
		animation.play("down")
		is_up = false
	else:
		animation.play("up")

func _on_animation_finished(anim_name):
	if anim_name ==  "down":
		cooldown_timer.start()
	elif anim_name == "up":
		is_up = true
		cooldown_timer.start()
