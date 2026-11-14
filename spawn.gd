extends Node2D

var object = preload("res://passenger.tscn")

func _on_button_pressed() -> void:
	var sprite_2d = object.instantiate()
	add_child(sprite_2d)
	sprite_2d.start()
