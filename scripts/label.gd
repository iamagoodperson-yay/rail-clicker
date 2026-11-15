extends Label

func _ready():
	text = 'Passengers: 0'

func _on_passengers_container_child_order_changed() -> void:
	text = 'Passengers: ' + str(Event.passenger_count)
