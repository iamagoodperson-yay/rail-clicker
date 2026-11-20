extends Label

func _process(_delta):
	text = 'Waiting passengers: %s' % Event.passenger_count
