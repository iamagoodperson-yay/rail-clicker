extends Node2D

const pass_scene = preload("res://scenes/passenger.tscn")
@onready var plat_node = $"../.."
@onready var plat_hitbox = $"../PlatformArea/Hitbox"
@onready var train_container = $"../TrainContainer/Path2D"
var train: Array[Node]

func _ready():
	train = train_container.get_children()
	spawnrate()

func spawn():
	plat_node.passenger_count += 1
	var passenger = pass_scene.instantiate()
	add_child(passenger)
	passenger.start(plat_hitbox, train)

func _on_add_button_pressed() -> void:
	if plat_node.passenger_count < 20:
		spawn()

func train_arrived():
	var active: Array[bool] = []
	for active_train in plat_node.train_passengers:
		active.append(active_train < plat_node.train_capacity.amt)
	for passenger in get_children():
		passenger.board_train(active)

func train_departed():
	for passenger in get_children():
		passenger.boarding = false

func spawnrate():
	var prev_spawnrate = 0.0
	while true:
		var rate = plat_node.spawnrate.amt
		if rate <= 0 or plat_node.passenger_count >= 20:
			prev_spawnrate = rate
			await get_tree().process_frame
			continue
		if rate != prev_spawnrate:
			prev_spawnrate = rate
		var timer = get_tree().create_timer(1.0 / rate)
		while timer.time_left > 0:
			await get_tree().process_frame
			if plat_node.spawnrate.amt != rate:
				break
		if plat_node.spawnrate.amt != rate:
			continue
		if plat_node.passenger_count < 20:
			spawn()

func _process(_delta: float) -> void:
	if plat_node.train_arrived:
		train_arrived()
	else:
		train_departed()
