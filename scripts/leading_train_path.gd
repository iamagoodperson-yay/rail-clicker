extends PathFollow2D

@onready var label = $Label
@onready var path2d = get_parent()
@onready var plat_node = $"../../../.."

const max_speed = 0.2
const acceleration = 0.05
var speed = max_speed

var children: int
var stop_point: float
var state = "c"
var accel_dist = (max_speed * max_speed) / (2 * acceleration)

func _ready():
	children = path2d.get_child_count()
	stop_point = 0.5 + (0.1370 * (children - 1.0)/2.0)
	progress_ratio = 0.0

func _process(delta: float) -> void:
	if plat_node.active:
		label.text = '%s/%s' % [plat_node.train_passengers, int(plat_node.train_capacity.amt)]
		linear_progress(delta)

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
		wait_at_end()


func wait_at_stop_point():
	plat_node.train_arrived = true
	var timer = get_tree().create_timer(15.0)
	while timer.time_left > 0:
		if plat_node.train_passengers >= plat_node.train_capacity.amt:
			break
		await get_tree().process_frame
	state = "a"
	plat_node.train_arrived = false

func wait_at_end():
	Event.money += plat_node.train_passengers * plat_node.fare.amt
	await get_tree().create_timer(plat_node.train_wait.amt).timeout
	plat_node.train_passengers = 0
	progress_ratio = 0.0
	speed = max_speed
	state = "c"
