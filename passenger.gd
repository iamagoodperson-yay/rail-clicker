extends Sprite2D

var active = false
var speed = 30
var angular_speed = PI/4

var action = 0

func start():
	active = true
	choose_action()
	

func choose_action():
	action = randi_range(1,2)
	await get_tree().create_timer(randf_range(0.5, 1.5)).timeout
	action = 0
	await get_tree().create_timer(randf_range(5.0, 10.0)).timeout

	if active:
		choose_action()

func _process(delta):
	if not active:
		return
	
	if action == 1:
		position += Vector2.UP.rotated(rotation) * speed * delta
	elif action == 2:
		rotation += angular_speed * delta
