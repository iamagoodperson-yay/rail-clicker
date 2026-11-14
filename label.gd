extends Label

var passengers = 0

func _ready():
	text = 'Passengers: ' + str(passengers)

func _on_button_pressed() -> void:
	passengers += 1
	text = 'Passengers: ' + str(passengers)
