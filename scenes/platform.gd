extends Node2D

var train_arrived = false
var passenger_count = 0
var train_passengers = 0

var train_capacity = Event.upgradable.new()
var train_wait = Event.upgradable.new()
var fare = Event.upgradable.new()

func _ready():
	train_capacity.base_amt = 10.0
	train_capacity.amt_inc = 2.0
	train_wait.base_amt = 16.0
	train_wait.amt_inc = -2.0
	train_wait.base_cost = 20.0
	train_wait.max_level = 8
	fare.base_amt = 1.0
	fare.amt_inc = 0.2


func _on_platform_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == 1:
				pass
