extends Area2D

@onready var plat_node = $"../../../../.."

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("passengers") and plat_node.train_arrived:
		plat_node.passenger_count -= 1
		plat_node.train_passengers += 1
		body.boarded()
