extends HFlowContainer

@onready var top_label = $'TopContainer/Label'
@onready var btm_label = $'BottomContainer/Label'
@onready var button = $'BottomContainer/Button'
@onready var error_label = get_node("/root/main/UI/ErrorLabel")

var obj = Event.train_capacity

func _process(_delta):
	top_label.text = "Train Capacity: %s" % obj.amt
	btm_label.text = "Level: %s\nCost: %s" % [obj.level, obj.cost]
	button.text = "Upgrade\n+%s capacity" % obj.amt_inc

func _on_button_pressed() -> void:
	if Event.money < obj.cost:
		error_label.text = "Error: Not enough money"
		error()
	elif obj.is_maxxed:
		error_label.text = "Error: Maximum level for upgrade"
		error()
	else:
		error_label.visible = false
		Event.upgrade(obj)

func error():
	error_label.visible = true
	await get_tree().create_timer(3.0).timeout
	error_label.visible = false
