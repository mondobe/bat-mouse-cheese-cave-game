class_name Level
extends Node2D

const CAMERA_MOVE_SPEED = 4.0

@onready var world: World = get_parent()
@onready var level_sprite: Sprite2D = $LevelSprite

@onready var bat: Bat = $Bat
@onready var mouse: Mouse = $Mouse
@onready var camera: Camera2D = $Camera2D

@onready var controlling_mouse = false
@onready var won = false

@onready var win_timer = 2.0

func _ready() -> void:
	# Define background region
	var level_dims = Vector2(level_sprite.texture.get_width(), level_sprite.texture.get_height())
	world.background_sprite.region_rect = Rect2(Vector2.ZERO, level_dims)
	camera.global_position = bat.global_position

func _process(delta: float) -> void:
	if controlling_mouse:
		camera.global_position = lerp(
			camera.global_position, mouse.global_position, delta * CAMERA_MOVE_SPEED)
	else:
		camera.global_position = lerp(
			camera.global_position, bat.global_position, delta * CAMERA_MOVE_SPEED)

	if Input.is_action_just_pressed("switch") and not won:
		controlling_mouse = not controlling_mouse
		mouse.controlling = controlling_mouse
		bat.controlling = not controlling_mouse

	if won:
		mouse.controlling = false
		bat.controlling = false
		win_timer -= delta
		if win_timer <= 0:
			world.next_level()
			win_timer = 10000
