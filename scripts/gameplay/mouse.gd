class_name Mouse
extends CharacterBody2D

const JUMP_VEL = -700
const MOVE_SPEED = 400
const VEL_DAMP = 0.004
const GRAVITY_SCALE = 0.1

@export var jump_sound: AudioStream
@export var eat_sound: AudioStream

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var jump_pressed: bool

@onready var controlling: bool = false

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * GRAVITY_SCALE

	var move_input: float = sign(Input.get_axis("left", "right"))
	if not controlling:
		move_input = 0

	if abs(move_input) > 0.5:
		velocity.x = move_input * MOVE_SPEED
		anim.flip_h = move_input > 0

	if is_on_floor():
		velocity.y = 0.0
		if (Input.is_action_pressed("carry") or Input.is_action_pressed("up")) and controlling:
			velocity.y = JUMP_VEL
			audio.stream = jump_sound
			audio.play()

	velocity.x *= pow(VEL_DAMP, delta)

	move_and_slide()

	if abs(move_input) > 0 or velocity.length_squared() > 50:
		anim.speed_scale = 1
	else:
		anim.speed_scale = 0

func got_cheese() -> void:
	if anim.visible:
		audio.stream = eat_sound
		audio.play()
		anim.hide()
