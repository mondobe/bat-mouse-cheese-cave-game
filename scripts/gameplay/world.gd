class_name World
extends Node2D

@onready var background_sprite: Sprite2D = $Background

var current_level: Node2D

@export var level_scenes: Array[PackedScene]
@onready var level_index: int = 0

func _ready() -> void:
	switch_level(level_scenes[0])

func switch_level(new_level_scene: PackedScene) -> void:
	if current_level:
		current_level.queue_free()
	var new_level = new_level_scene.instantiate()
	add_child(new_level)
	current_level = new_level

func next_level() -> void:
	level_index += 1
	switch_level(level_scenes[level_index])
