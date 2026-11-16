extends Control

@onready var money_label = $MoneyLabel
@onready var passenger_label = $PassengerLabel

func _process(delta):
	money_label.text = 'Money: %s' % Event.money
	passenger_label.text = 'Waiting passengers: %s' % Event.passenger_count 
