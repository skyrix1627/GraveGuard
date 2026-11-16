extends CharacterBody2D

var dialogue_resource = preload("res://dialogue/characters/cashier.dialogue")
var talking := false

func start_dialogue() -> void:
	print("start_dialogue")
	if talking or GameData.shop_open:
		return
	talking = true
	GameData.in_dialogue = true
	DialogueManager.show_dialogue_balloon(dialogue_resource, "intro")
	await DialogueManager.dialogue_ended
	talking = false
	if not GameData.shop_open:
		GameData.in_dialogue = false
