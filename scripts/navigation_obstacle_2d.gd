extends NavigationObstacle2D

var previous_position: Vector2

func _ready():
	previous_position = global_position

func _physics_process(delta):
	velocity = (global_position - previous_position) / delta
	previous_position = global_position
