extends PathFollow2D

@onready var control = $Control
@onready var label = $"Control/Label"
@onready var path2d = get_parent()
@onready var plat_node = $"../../../.."

const max_speed = 0.2
const acceleration = 0.05
var speed = max_speed

var children: int
var stop_point: float
var state = "c"
var accel_dist = (max_speed * max_speed) / (2 * acceleration)

var flipped = false

func _ready():
	children = path2d.get_child_count()
	stop_point = 0.5 + (0.1370 * (children - 1.0)/2.0)
	progress_ratio = 0.0

func _process(delta: float) -> void:
	if plat_node.active:
		label.text = '%s/%s' % [plat_node.train_passengers[0], int(plat_node.train_capacity.amt)]
		linear_progress(delta)
		if flipped:
			control.rotation = PI

func linear_progress(delta) -> void:
	match state:
		"d":
			speed = move_toward(speed, 0.0, acceleration * delta)
			if speed <= 0.0:
				progress_ratio = stop_point
				speed = 0.0
				state = "m"
				wait_at_stop_point()
		"c":
			if progress_ratio >= stop_point - accel_dist and progress_ratio < stop_point:
				state = "d"
		"a":
			speed = move_toward(speed, max_speed, acceleration * delta)
			if speed >= max_speed:
				speed = max_speed
				state = "c"
		"m", "e":
			return
	progress_ratio += speed * delta

	if progress_ratio >= 1.0:
		progress_ratio = 1.0
		speed = 0.0
		state = "e"
		for passengers in plat_node.train_passengers:
			Event.money += passengers * plat_node.fare.amt
		wait_at_end()


func wait_at_stop_point():
	plat_node.train_arrived = true
	var capacity = plat_node.train_capacity.amt
	var timer = get_tree().create_timer(15.0)
	while timer.time_left > 0:
		var filled = 0
		for passengers in plat_node.train_passengers:
			if passengers >= capacity:
				filled += 1
		if filled == plat_node.train_passengers.size():
			break
		await get_tree().process_frame
	state = "a"
	plat_node.train_arrived = false

func wait_at_end():
	var wait = plat_node.train_wait.amt
	var timer = get_tree().create_timer(wait)
	while timer.time_left > 0:
		await get_tree().process_frame
		if plat_node.train_wait.amt != wait:
			break
	if plat_node.train_wait.amt != wait:
		wait_at_end()
	for i in range(plat_node.train_passengers.size()):
		plat_node.train_passengers[i] = 0
	progress_ratio = 0.0
	speed = max_speed
	state = "c"
