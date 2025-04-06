class_name Bat
extends RigidBody2D

const SIDE_MOVE_VEL = 200.0
const FLY_VEL_UNENCUMBERED = -200.0
const FLY_VEL_ENCUMBERED = -250.0
const DIVE_VEL = 500.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var carry_detector: Area2D = $CarryDetector
@onready var carry_joint: PinJoint2D = $CarryJoint

@onready var hanging: bool = true

var carry_pressed: bool
var carrying: RigidBody2D
@onready var carryable: Array

@onready var controlling: bool = true

func _ready() -> void:
	carry_detector.body_entered.connect(
		func(body: PhysicsBody2D):
			print(body.name)
			if body.is_in_group("carryable"):
				carryable.append(body)
	)
	carry_detector.body_exited.connect(
		func(body: PhysicsBody2D):
			carryable.erase(body)
	)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("carry"):
		carry_pressed = true

func _physics_process(delta: float) -> void:
	var fly_input = Input.get_vector("left", "right", "up", "down").normalized()
	if not controlling:
		fly_input = Vector2.ZERO

	if fly_input.length_squared() > 0:
		hanging = false

	freeze = hanging

	if hanging:
		anim.animation = "hang"
	else:
		if fly_input.y <= -0.5:
			linear_velocity.y = (FLY_VEL_ENCUMBERED if carrying else FLY_VEL_UNENCUMBERED)
			anim.animation = "flap"
		elif fly_input.y >= 0.5:
			linear_velocity.y = DIVE_VEL
			anim.animation = "dive"
		else:
			anim.animation = "float"

	if abs(fly_input.x) >= 0.5:
		anim.flip_h = fly_input.x < 0
		linear_velocity.x = fly_input.x * SIDE_MOVE_VEL

	# Process carry
	if carry_pressed and controlling:
		if carrying:
			carrying = null
			carry_joint.node_b = ""
		elif not carryable.is_empty():
			var rb_to_carry: PhysicsBody2D = carryable[len(carryable) - 1]
			carry_joint.node_b = rb_to_carry.get_path()
			carrying = rb_to_carry

	carry_pressed = false
