extends Control

var items = {
	"energy_drink": {"name": "Energy Drink", "price": 15},
	"shovel": {"name": "Shovel", "price": 30},
	"beer": {"name": "Beer", "price": 20},
}

@onready var money_label: Label = %MoneyLabel
@onready var item_list: VBoxContainer = %ItemList

func _ready() -> void:
	for id in items:
		var item = items[id]
		var button = Button.new()
		button.text = "%s - %d coins" % [item.name, item.price]
		button.pressed.connect(_on_buy.bind(id))
		item_list.add_child(button)

	GameData.money_changed.connect(update_money)
	%CloseButton.pressed.connect(close_shop)
	update_money()

func update_money() -> void:
	money_label.text = "Money: %d" % GameData.money

func _on_buy(id: String) -> void:
	var price = items[id].price
	if GameData.money >= price:
		GameData.money -= price
		GameData.add_item(id)
	else:
		print("Not enough money!")

func close_shop() -> void:
	queue_free()
