extends PathFollow2D

@export var leading: PathFollow2D
var distance_behind = 255.0

@onready var label = $Label

func _process(delta: float) -> void:
	label.text = '%s/%s' % [Event.train_passengers, int(Event.train_capacity.amt)]
	if leading.progress_ratio == 1.0:
		if progress_ratio >= 1.0:
			progress_ratio = 1.0
		progress_ratio += leading.max_speed * delta
	else:
		progress = leading.progress - distance_behind
