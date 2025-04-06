class_name World
extends Node

@onready var background_sprite: Sprite2D = $Background

var current_level: Node

@export var level_scenes: Array[PackedScene]
@export var start_level: int
@onready var level_index: int = start_level

func play() -> void:
	switch_level(level_scenes[start_level])

func switch_level(new_level_scene: PackedScene) -> void:
	if current_level:
		current_level.queue_free()
	var new_level = new_level_scene.instantiate()
	add_child(new_level)
	current_level = new_level

func next_level() -> void:
	level_index += 1
	switch_level(level_scenes[level_index])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		switch_level(level_scenes[level_index])
