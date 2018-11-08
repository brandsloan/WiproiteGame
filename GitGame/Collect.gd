extends Node

func _ready():
	get_node("Area2D").connect("body_enter", self, "_collect_artifact")
	
func _collect_artifact(body):
	print("Collecting")
	queue_free()
	pass