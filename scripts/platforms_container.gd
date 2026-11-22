extends Node2D

const plat_scene = preload("res://scenes/platform.tscn")
const center = Vector2(576.0, 324.0)
const offset = Vector2(0.0, 260.0)

func _ready() -> void:
	var platform = plat_scene.instantiate()
	platform.position = center + offset * get_child_count()
	#add_child(platform)
