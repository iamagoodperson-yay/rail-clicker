extends Area2D

@onready var plat_node = $"../../../../.."
@onready var index = int(str(get_parent().name)[-1]) -1
@onready var obstacle = $"../NavigationObstacle2D"

func _ready():
	obstacle.avoidance_enabled = true
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("passengers") and plat_node.train_arrived:
		if plat_node.train_passengers[index] < plat_node.train_capacity.amt:
			plat_node.passenger_count -= 1
			plat_node.train_passengers[index] += 1
			body.boarded()
			if plat_node.train_passengers[index] == plat_node.train_capacity.amt:
				obstacle.avoidance_enabled = true
