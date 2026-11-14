extends Sprite2D

var active = false

var speed = 30
var angular_speed = PI/4
var action = 0

var platform
var plat_shape: RectangleShape2D
var plat_size: Vector2
const plat_padding = 16

func start(platform_ref):	
	platform = platform_ref
	active = true
	visible = true
	rotation = randf_range(0,TAU)
	
	plat_shape = platform.shape as RectangleShape2D
	plat_size = plat_shape.size

	var random_position = Vector2(
		randf_range(-plat_size.x/2 + plat_padding, plat_size.x/2 - plat_padding),
		randf_range(-plat_size.y/2 + plat_padding, plat_size.y/2 - plat_padding)
	)

	global_position = platform.to_global(random_position)
	choose_action()

func choose_action():
	while active:
		action = 0
		await get_tree().create_timer(randf_range(2.5, 10.0)).timeout
		action = randi_range(1,2)
		await get_tree().create_timer(randf_range(0.5, 1.5)).timeout

func _process(delta):
	if not active:
		return

	if action == 1:
		position += Vector2.UP.rotated(rotation) * speed * delta
	elif action == 2:
		rotation += angular_speed * delta

	var local_position = platform.to_local(global_position)
	if abs(local_position.x) > plat_size.x/2 - plat_padding or abs(local_position.y) > plat_size.y / 2 - plat_padding:
		position -= Vector2.UP.rotated(rotation) * speed * delta
		action = 0
