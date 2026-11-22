extends CanvasLayer

@onready var money_label = $MoneyLabel
@onready var upgrade_foldable = $FoldableContainer

func _process(_delta):
	upgrade_foldable.visible = Event.first_select
	money_label.text = 'Money: %s' % Event.money
