extends PathFollow2D

@onready var control = $Control
@onready var label = $"Control/Label"
@onready var plat_node = $"../../../.."
@export var leading: PathFollow2D

var distance_behind = 255.0
var flipped = false

func _process(delta: float) -> void:
	label.text = '%s/%s' % [plat_node.train_passengers, int(plat_node.train_capacity.amt)]
	if flipped:
		control.rotation = PI
	if leading.progress_ratio == 1.0:
		if progress_ratio >= 1.0:
			progress_ratio = 1.0
		progress_ratio += leading.max_speed * delta
	else:
		progress = leading.progress - distance_behind
