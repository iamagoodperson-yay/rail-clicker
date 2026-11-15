extends CharacterBody2D

var active = false
var boarding = false

var speed = 30
var angular_speed = PI/4
var action = 0

var platform: Variant
var plat_shape: RectangleShape2D
var plat_size: Vector2
const plat_padding = 16

var train: Node2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func start(platform_ref, train_ref):
	platform = platform_ref
	train = train_ref
	
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
		
func board_train():
	if not active or boarding:
		return

	boarding = true
	nav_agent.target_position = train.global_position

func keep_to_platform():
	var local_position = platform.to_local(global_position)
	local_position.x = clamp(
		local_position.x,
		-plat_size.x / 2 + plat_padding,
		plat_size.x / 2 - plat_padding
	)
	local_position.y = clamp(
		local_position.y,
		-plat_size.y / 2 + plat_padding,
		plat_size.y / 2 - plat_padding
	)
	global_position = platform.to_global(local_position)

func boarded():
	active = false
	boarding = false
	velocity = Vector2.ZERO
	queue_free()

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	if boarding:
		var next_pos = nav_agent.get_next_path_position()
		velocity = global_position.direction_to(next_pos) * speed
		
	else: 
		match action:
			1:
				velocity = Vector2.UP.rotated(rotation) * speed
			2:
				velocity = Vector2.ZERO
				rotation += angular_speed * delta
			_:
				velocity = Vector2.ZERO
		keep_to_platform()
		
	move_and_slide()
