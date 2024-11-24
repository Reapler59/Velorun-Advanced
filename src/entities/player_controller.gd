extends CharacterBody2D
class_name Player

#region variables & constants
@onready var sprites = $Sprites
@onready var animation_body = $AnimationPlayerBody
@onready var animation_eyes = $AnimationPlayerEyes
@onready var camera = $Camera2D
@onready var ray_floor = $RayCasts/RayFloor
@onready var ray_wall = $RayCasts/RayWall
@onready var ray_conveyor = $RayCasts/RayConveyor

enum Direction {LEFT, RIGHT}

var facing_direction: Direction = Direction.RIGHT
var direction_multiplier: int = 1

var speed: int = 200
var acceleration: int = 1600
var friction: int = 1800

var floor_damping : float

const GRAVITY: int = 1000
const FALL_GRAVITY: int = 2000
const WALL_GRAVITY: int = 30

var jump_impulse: int = -450
var wall_jump_impulse: int = -300
var wall_jump_pushback: int = 350

var jump_buffer_time: float = 0.1
var coyote_time: float = 0.1
var jump_buffer: Timer
var coyote_timer: Timer

var coyote_jump_available: bool = false

var horizontal_input
var jump_attempted

var is_on_conveyor_wall: bool = false

var speed_modifier_x: int = 0
var speed_modifier_y: int = 0
var friction_modifier: float = 1
#endregion

func _ready() -> void:
	jump_buffer = Timer.new()
	jump_buffer.wait_time = jump_buffer_time
	jump_buffer.one_shot = true
	add_child(jump_buffer)
	
	coyote_timer = Timer.new()
	coyote_timer.wait_time = coyote_time
	coyote_timer.one_shot = true
	add_child(coyote_timer)
	coyote_timer.timeout.connect(coyote_timeout)

func _physics_process(delta) -> void:
	handle_movement(delta)
	handle_jump(delta)
	handle_falling(delta)
	handle_raycast_collisions(delta)
	
	move_and_slide()

func handle_movement(delta) -> void:
	horizontal_input = Input.get_axis("left", "right")
	floor_damping = 1.0 if is_on_floor() else 0.2
	
	if horizontal_input:
		if not ray_wall.is_colliding():
			animation_body.play("move")
		
		if horizontal_input > 0:
			change_direction(Direction.RIGHT)
		elif horizontal_input < 0:
			change_direction(Direction.LEFT)
	
		velocity.x = move_toward(velocity.x, horizontal_input * speed + speed_modifier_x, acceleration * delta)
	else:	
		velocity.x = move_toward(velocity.x, 0, ((friction * friction_modifier) * delta) * floor_damping)
	
	if velocity == Vector2.ZERO or velocity.x == speed_modifier_x:
		animation_body.play("idle")

func handle_jump(delta) -> void:
	jump_attempted = Input.is_action_just_pressed("jump")
	
	if jump_attempted or jump_buffer.time_left > 0:
		if is_on_floor():
			animation_eyes.play("look_up")
			velocity.y = jump_impulse
		elif coyote_jump_available:
			animation_eyes.play("look_up")
			velocity.y = jump_impulse
			coyote_jump_available = false
		elif not is_on_floor() and ray_wall.is_colliding():
			velocity.y = wall_jump_impulse
			velocity.x = wall_jump_pushback * -direction_multiplier
			switch_direction()
	
	if jump_attempted and not is_on_floor():
		jump_buffer.start()
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = jump_impulse / 4

func handle_falling(delta):
	if velocity.y > 0:
		animation_eyes.play("look_down")
		if ray_wall.is_colliding():
			animation_body.play("wall_slide")
	
	if is_on_floor():
		animation_eyes.play("blink")
		coyote_jump_available = true
		coyote_timer.stop()
	else:
		if coyote_jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start()
		if not is_on_conveyor_wall:
			velocity.y += gravity(horizontal_input) * delta
		else:
			velocity.y = gravity(horizontal_input) * delta

func gravity(input_dir : float = 0) -> float:
	if velocity.y > 0 and ray_wall.is_colliding() and not is_on_conveyor_wall:
		return WALL_GRAVITY
	elif is_on_conveyor_wall:
		return 0
	else:
		return GRAVITY if velocity.y < 0 else FALL_GRAVITY

func change_direction(new_direction: Direction) -> void:
	facing_direction = new_direction
	if facing_direction == Direction.LEFT:
		direction_multiplier = -1
		sprites.scale.x = -1
		ray_wall.target_position.x = -16
		ray_conveyor.target_position.x = -16
	else:
		direction_multiplier = 1
		sprites.scale.x = 1
		ray_wall.target_position.x = 16
		ray_conveyor.target_position.x = 16

func switch_direction() -> void:
	if facing_direction == Direction.LEFT:
		facing_direction = Direction.RIGHT
	else:
		facing_direction = Direction.LEFT
	
	direction_multiplier *= -1
	sprites.scale.x *= -1
	ray_wall.target_position.x *= -1
	ray_conveyor.target_position.x *= -1

func set_camera_limit(value: int):
	camera.limit_right = value

func handle_raycast_collisions(delta) -> void:
	if ray_conveyor.is_colliding():
		is_on_conveyor_wall = true
		speed_modifier_y = -100
		
		if velocity.y == 0:
			velocity.y = speed_modifier_y
		else:
			velocity.y = move_toward(velocity.y, velocity.y + speed_modifier_y, delta)
	else:
		is_on_conveyor_wall = false
		speed_modifier_y = 0
	
	if ray_floor.is_colliding():
		friction_modifier = 0.1
	else:
		friction_modifier = 1

func coyote_timeout():
	coyote_jump_available = false
