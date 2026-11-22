extends HFlowContainer

@onready var top_label = $'TopContainer/Label'
@onready var btm_label = $'BottomContainer/Label'
@onready var button = $'BottomContainer/Button'
@onready var error_label = get_node("/root/main/UI/ErrorLabel")

var obj: Event.upgradable

func _process(_delta):
	if Event.curr_select == null:
		return
	obj = Event.curr_select.train_wait
	
	top_label.text = "Time between trains: %s sec/train" % obj.amt
	btm_label.text = "Level: %s\nCost: %s" % [obj.level, obj.cost]
	button.text = "Upgrade\n%s sec/train" % obj.amt_inc

	button.disabled = Event.money < obj.cost or obj.is_maxxed

func _on_button_pressed() -> void:
	Event.upgrade(obj)
