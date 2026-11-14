extends Label
@onready var passengers = get_node("/root/main/Node2D/PassengersContainer")

func _ready():
	text = 'Passengers: 0'

func _on_button_pressed() -> void:
	text = 'Passengers: ' + str(passengers.get_child_count())
