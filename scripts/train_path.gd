extends PathFollow2D

const max_speed = 0.2
const acceleration = 0.05
var speed = max_speed

const midpoint = 0.5
var state = "c"
var accel_dist = (max_speed * max_speed) / (2 * acceleration)

func _process(delta: float) -> void:
	linear_progress(delta)

func linear_progress(delta) -> void:
	match state:
		"d":
			speed = move_toward(speed, 0.0, acceleration * delta)
			if speed <= 0.0:
				speed = 0.0
				state = "m"
				wait_at_midpoint()
		"c":
			if progress_ratio >= midpoint - accel_dist and progress_ratio < midpoint:
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


func wait_at_midpoint():
	Event.train_arrived = true
	var timer = get_tree().create_timer(20.0)
	while get_tree().get_node_count_in_group("passengers") > 0:
		if timer.time_left <= 0:
			break
		if Event.train_passengers > Event.
		await get_tree().process_frame
	state = "a"
	Event.train_arrived = false
	
func wait_at_end():
	await get_tree().create_timer(10.0).timeout
	progress_ratio = 0.0
	speed = max_speed
	state = "c"
