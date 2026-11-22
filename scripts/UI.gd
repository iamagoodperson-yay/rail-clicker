extends CanvasLayer

@onready var money_label = $MoneyLabel
@onready var upgrade_foldable = $FoldableContainer
@onready var error_label = $ErrorLabel

func _ready():
	error_label.visible = false

func _process(_delta):
	upgrade_foldable.visible = Event.first_select
	money_label.text = 'Coins: %s' % Event.money
