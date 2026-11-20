extends Node

var train_arrived = false
var passenger_count = 0
var train_passengers = 0
var money = 0

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

var train_capacity = upgradable.new()
var train_wait = upgradable.new()
var fare = upgradable.new()

func _ready():
	train_capacity.base_amt = 10.0
	train_capacity.amt_inc = 2.0
	train_wait.base_amt = 16.0
	train_wait.amt_inc = -2.0
	train_wait.base_cost = 20.0
	train_wait.max_level = 8
	fare.base_amt = 1.0
	fare.amt_inc = 0.2

func upgrade(up: upgradable) -> upgradable:
	money -= up.cost
	up.level += 1
	return up
