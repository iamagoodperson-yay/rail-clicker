extends Label

@onready var plat_node = get_parent()

func _process(_delta):
	text = 'Waiting passengers: %s' % plat_node.passenger_count
