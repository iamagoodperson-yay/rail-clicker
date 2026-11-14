extends Node2D

var object = preload("res://scenes/passenger.tscn")
@onready var platform = $"../Platform/Hitbox"

func _on_button_pressed() -> void:
	var passenger = object.instantiate()
	add_child(passenger)
	passenger.start(platform)
