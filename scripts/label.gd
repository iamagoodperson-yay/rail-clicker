extends Label
@onready var passengers = $"../../NavigationRegion2D/PassengersContainer"

func _ready():
	text = 'Passengers: 0'

func _on_passengers_container_child_order_changed() -> void:
	text = 'Passengers: ' + str(passengers.get_child_count())
