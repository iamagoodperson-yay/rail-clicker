extends HFlowContainer

@onready var top_label = $'TopContainer/Label'
@onready var btm_label = $'BottomContainer/Label'
@onready var button = $'BottomContainer/Button'

var obj: Event.upgradable

func _process(_delta):
	if Event.curr_select == null:
		return
	obj = Event.curr_select.fare
	
	top_label.text = "Fare per passenger: %s" % obj.amt
	btm_label.text = "Level: %s\nCost: %s" % [obj.level, obj.cost]
	button.text = "Upgrade\n+%s coins/passenger" % obj.amt_inc

	button.disabled = Event.money < obj.cost or obj.is_maxxed

func _on_button_pressed() -> void:
	Event.upgrade(obj)
