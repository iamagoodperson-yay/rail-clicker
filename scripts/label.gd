extends Label

func _process(delta):
	text = 'Passengers: %s\nMoney: %s' % [Event.passenger_count, Event.money]
