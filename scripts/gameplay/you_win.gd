class_name YouWin
extends Node2D

@onready var world: World = get_parent()
@onready var level_sprite: Sprite2D = $LevelSprite

func _ready() -> void:
	# Define background region
	var level_dims = Vector2(level_sprite.texture.get_width(), level_sprite.texture.get_height())
	world.background_sprite.region_rect = Rect2(Vector2.ZERO, level_dims)
