extends HFlowContainer

@onready var top_label = $'TopContainer/Label'
@onready var btm_label = $'BottomContainer/Label'
@onready var button = $'BottomContainer/Button'
@onready var error_label = $'../../../ErrorLabel'

var obj = Event.fare

func _process(delta):
	top_label.text = "Fare: %s" % obj.amt
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
		obj.level += 1

func error():
	error_label.visible = true
	await get_tree().create_timer(5.0).timeout
	error_label.visible = false
