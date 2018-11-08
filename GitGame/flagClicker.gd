extends Area2D

export var lvlSelect = ''

func _input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
        self.on_click()

func on_click():
	#change scene
	print("Entering the level")
	get_tree().change_scene(lvlSelect)