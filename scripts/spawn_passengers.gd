extends Node2D

var pass_scene = preload("res://scenes/passenger.tscn")
@onready var platform = $"../PlatformArea/Hitbox"
@onready var train = $"../Path2D/PathFollow2D/Train"

func _on_add_button_pressed() -> void:
	Event.passenger_count += 1
	var passenger = pass_scene.instantiate()
	add_child(passenger)
	passenger.start(platform, train)

func _on_rest_button_pressed() -> void:
	for passenger in get_children():
		passenger.start(platform, train)

func train_arrived():
	for passenger in get_children():
		passenger.board_train()

func train_departed():
	for passenger in get_children():
		passenger.boarding = false

func _process(delta: float) -> void:
	if Event.train_arrived:
		train_arrived()
	else:
		train_departed()
