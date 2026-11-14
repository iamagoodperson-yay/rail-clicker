extends Label

var passenger_count = 0

func _ready():
	text = 'Passengers:' + str(passenger_count)

func _on_button_pressed() -> void:
	passenger_count += 1
	text = 'Passengers: ' + str(passenger_count)
