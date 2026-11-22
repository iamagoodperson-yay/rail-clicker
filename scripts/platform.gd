extends Node2D

@onready var nav_region = $NavigationRegion2D
@onready var pass_label = $PassengerLabel
@onready var add_btn = $AddButton
@onready var selected_label = $SelectedLabel
@onready var buy_btn_control = $BuyBtnControl
@onready var buy_btn = $'BuyBtnControl/BuyButton'
@onready var path2d = $"NavigationRegion2D/TrainContainer/Path2D"

var active = false
var cost = 0

var train_capacity = Event.upgradable.new()
var train_wait = Event.upgradable.new()
var fare = Event.upgradable.new()

var train_arrived = false
var passenger_count = 0
var train_passengers = 0

func _ready():
	nav_region.visible = false
	pass_label.visible = false
	add_btn.visible = false
	selected_label.visible = false
	buy_btn_control.visible = true
	
	train_capacity.base_amt = 10.0
	train_capacity.amt_inc = 2.0
	train_wait.base_amt = 16.0
	train_wait.amt_inc = -2.0
	train_wait.base_cost = 20.0
	train_wait.max_level = 8
	fare.base_amt = 1.0
	fare.amt_inc = 0.2

func activate(flip: bool):
	active = true
	
	nav_region.visible = true
	pass_label.visible = true
	add_btn.visible = true
	buy_btn_control.visible = false
	if flip:
		nav_region.rotation = PI
		pass_label.position.y -= 226
		add_btn.position.y -= 130
		selected_label.position.y -= 130
		for path_follow in path2d.get_children():
			path_follow.flipped = true

func _on_platform_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == 1:
				Event.set_current_upgrades(self)

func _on_buy_button_pressed() -> void:
	if Event.money >= cost:
		Event.active_plat += 1
		Event.money -= cost
		activate(Event.active_plat % 2 == 0)

func _process(_delta: float) -> void:
	pass_label.text = 'Waiting passengers: %s' % passenger_count
	buy_btn.text = 'Buy New Platform: %s' % cost
