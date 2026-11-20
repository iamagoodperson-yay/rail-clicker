extends Camera2D

var speed = 300.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_W) or Input.is_action_pressed('ui_up'):
		offset.y -= speed * delta
	if Input.is_key_pressed(KEY_S) or Input.is_action_pressed('ui_down'):
		offset.y += speed * delta
