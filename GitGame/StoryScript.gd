extends Node

var textOption = 0
var text = ["Your journey is about to begin.", 
			"The gods of our myths are real.", 
			"They have led their ancient civilizations to the space age.",
			"With your loved ones held by the nefarious Beholder, will you manage to defeat these deities of old armed with modern technology?",
			"Or will you fall into ruin?",
			 "Exit"]
var textBox = null
var toMove = null

func _ready():
	textBox = get_node("TextBox")
	toMove = textBox.get_node("Area2D")
	print(toMove.cur)
	textBox.text = text[toMove.cur]

func _process(delta):
	if(toMove.cur < text.size()-1):
		textBox.text = text[toMove.cur]
	else:
		get_tree().change_scene("res://Label.tscn")