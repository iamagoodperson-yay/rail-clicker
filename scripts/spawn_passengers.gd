extends Node2D


var pass_scene = preload("res://scenes/passenger.tscn")
@onready var platform = $"../PlatformArea/Hitbox"
@onready var train = $"../Path2D/PathFollow2D/Train"

func _on_button_pressed() -> void:
	var passenger = pass_scene.instantiate()
	add_child(passenger)
	passenger.start(platform, train)

func train_arrived():
	for passenger in get_children():
		passenger.board_train()
		
func _process(delta: float) -> void:
	if Event.train_arrived:
		train_arrived()
