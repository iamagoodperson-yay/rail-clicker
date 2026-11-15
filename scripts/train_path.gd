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
				progress_ratio = midpoint
				state = "c"
				wait_at_midpoint()
		"c":
			if progress_ratio >= midpoint - accel_dist and progress_ratio < midpoint:
				state = "d"
		"a":
			speed = move_toward(speed, max_speed, acceleration * delta)
			if speed >= max_speed:
				speed = max_speed
				state = "c"
	progress_ratio += speed * delta

	if progress_ratio >= 1.0:
		progress_ratio = 0.0
		speed = max_speed
		state = "c"


func wait_at_midpoint():
	Event.train_arrived = true
	await get_tree().create_timer(10.0).timeout
	state = "a"
	Event.train_arrived = false

func spawn_wait():
	await get_tree().create_timer(randf_range(10.0, 20.0)).timeout
