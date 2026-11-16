extends Node

signal money_changed

var in_dialogue := false
var shop_open := false

var money := 100:
	set(value):
		money = value
		money_changed.emit()

var inventory := {}

func add_item(id: String) -> void:
	inventory[id] = inventory.get(id, 0) + 1

func open_shop() -> void:
	print("open_shop called")
	if shop_open:
		return
	shop_open = true
	in_dialogue = true

	var layer := CanvasLayer.new()
	layer.layer = 101  # draw above the dialogue balloon
	var shop = load("res://scenes/shop.tscn").instantiate()
	layer.add_child(shop)
	get_tree().current_scene.add_child(layer)

	shop.tree_exited.connect(func():
		layer.queue_free()
		shop_open = false
		in_dialogue = false
	)
