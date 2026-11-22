extends HFlowContainer

@onready var top_label = $'TopContainer/Label'
@onready var btm_label = $'BottomContainer/Label'
@onready var button = $'BottomContainer/Button'
@onready var error_label = get_node("/root/main/UI/ErrorLabel")

var obj: Event.upgradable

func _process(_delta):
	if Event.curr_select == null:
		return
	obj = Event.curr_select.fare
	
	top_label.text = "Fare per passenger: %s" % obj.amt
	btm_label.text = "Level: %s\nCost: %s" % [obj.level, obj.cost]
	button.text = "Upgrade\n+%s Fare" % obj.amt_inc

func _on_button_pressed() -> void:
	if Event.money < obj.cost:
		error("Not enough money")
	elif obj.is_maxxed:
		error("Maximum level for upgrade")
	else:
		error_label.visible = false
		Event.upgrade(obj)

func error(text):
	error_label.text = "Error: %s" % text
	error_label.visible = true
	await get_tree().create_timer(3.0).timeout
	error_label.visible = false
