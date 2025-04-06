class_name Cheese
extends Node2D

@export var level: Node2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D = $Area2D

func _ready() -> void:
	area.body_entered.connect(
		func(body: PhysicsBody2D):
			print(body.name)
			if body == level.mouse:
				body.got_cheese()
				anim.animation = "got"
				level.won = true
	)
