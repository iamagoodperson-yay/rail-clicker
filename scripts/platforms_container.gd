extends Node2D

const plat_scene = preload("res://scenes/platform.tscn")
const center = Vector2(576.0, 324.0)
const offset = Vector2(0.0, 260.0)

func _ready() -> void:
	var platform = plat_scene.instantiate()
	platform.position = center
	add_child(platform)

func add_new_platform():
	var platform = plat_scene.instantiate()
	var plat_count = get_child_count()
	platform.position = center + offset * plat_count
	platform.cost = roundi(100 * pow(2, plat_count-1))
	add_child(platform)

func _process(_delta: float) -> void:
	if get_child_count() == Event.active_plat:
		add_new_platform()
