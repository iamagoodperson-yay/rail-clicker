extends Node2D

const pass_scene = preload("res://scenes/passenger.tscn")
@onready var plat_node = $"../.."
@onready var plat_hitbox = $"../PlatformArea/Hitbox"
@onready var train_container = $"../TrainContainer/Path2D"
var train: Array[Node]

func _ready():
	train = train_container.get_children()
	pass

func _on_add_button_pressed() -> void:
	if plat_node.passenger_count < 20:
		plat_node.passenger_count += 1
		var passenger = pass_scene.instantiate()
		add_child(passenger)
		passenger.start(plat_hitbox, train)

func train_arrived():
	for passenger in get_children():
		passenger.board_train()

func train_departed():
	for passenger in get_children():
		passenger.boarding = false

func _process(_delta: float) -> void:
	if plat_node.train_arrived:
		train_arrived()
	else:
		train_departed()
