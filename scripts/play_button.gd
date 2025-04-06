extends Node

func play() -> void:
	queue_free()
	get_parent().play()
