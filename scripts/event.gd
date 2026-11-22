extends Node

class upgradable:
	var level: int = 0
	var base_amt: float = 1.0
	var amt_inc: float = 1.0
	var max_level: int = 999
	
	var is_maxxed: bool:
		get:
			return max_level == level
	
	var amt: float: 
		get:
			return max(base_amt + level * amt_inc , 0.0)
	
	var base_cost: int = 10
	var multiplier: float = 1.1
	
	var cost: int:
		get:
			return roundi(base_cost * pow(multiplier, level))

var money = 1000
var active_plat = 0
var first_select = false
var curr_select: Node

func upgrade(up: upgradable):
	money -= up.cost
	up.level += 1

func set_current_upgrades(curr: Node):
	if curr_select:
		curr_select.selected_label.visible = false

	first_select = true
	curr_select = curr
	curr_select.selected_label.visible = true
