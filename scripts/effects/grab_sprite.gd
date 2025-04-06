extends AnimatedSprite2D

func _ready() -> void:
	animation_finished.connect(
		func():
			if animation == "grow":
				play("circle")
	)
