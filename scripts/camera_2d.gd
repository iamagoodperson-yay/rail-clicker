extends Camera2D

var speed = 400.0
var max_speed = 1000.0
var accel = 25.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_W) or Input.is_action_pressed('ui_up'):
		offset.y -= speed * delta
		speed += accel
	elif Input.is_key_pressed(KEY_S) or Input.is_action_pressed('ui_down'):
		offset.y += speed * delta
		speed += accel
	else:
		speed = 400.0
	
	offset.y = clamp(
		offset.y,
		-558,
		300 + 324 * Event.active_plat
	)
