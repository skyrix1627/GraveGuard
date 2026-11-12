extends Control

@onready var story_text: RichTextLabel = $MarginContainer/RichTextLabel
@onready var continue_label: Label = $Label

var pages: Array[String] = [
	"You recently moved to a small town for your new job as a grave guard.",
	"But the town carries a strange aura. You felt it the moment you arrived, though you couldn't say what it was.",
	"Locals whisper of ghosts and zombies wandering the graveyard at night, and of the last grave guards who vanished without a trace.",
	"Graves are being dug up overnight, the bodies gone and the valuables buried with them missing. No one can say who, or why.",
	"But who believes in ghost stories? Only a child or a paranoid elder would fall for something so far-fetched.",
	"And the graves dug open? Surely it's nothing more than hungry wild animals searching for a meal."
	]

var current_page := 0
var finished_typing := false
var tween: Tween

func _ready():
	show_page(0)

func show_page(index: int):
	current_page = index
	finished_typing = false
	continue_label.visible = false

	story_text.text = pages[index]
	story_text.visible_ratio = 0.0

	# Typewriter effect: ~0.04 seconds per character
	var duration = pages[index].length() * 0.04
	tween = create_tween()
	tween.tween_property(story_text, "visible_ratio", 1.0, duration)
	tween.finished.connect(_on_typing_finished)

func _on_typing_finished():
	finished_typing = true
	continue_label.visible = true

func _input(event):
	if not event.is_pressed() or event.is_echo():
		return

	if not finished_typing:
		# Skip the typing and show the whole page
		tween.kill()
		story_text.visible_ratio = 1.0
		_on_typing_finished()
	else:
		# Go to the next page, or start the game after the last one
		if current_page < pages.size() - 1:
			show_page(current_page + 1)
		else:
			start_game()

func start_game():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
