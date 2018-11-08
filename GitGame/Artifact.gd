extends Node2D

const waitTime = 2
var timer = null
var art = null

func _ready():
	timer = get_node("Timer")
	art = get_node("Area2D")
	timer.set_wait_time(waitTime)
	if get_owner() != null:
		pass
	timer.connect("timeout", self, "_on_Timer_timeout")
	art.connect("body_entered", self, "_collect_artifact")
	
func _collect_artifact(body):
	timer.start()
	get_node("Eye").hide()
	
	
func _on_Timer_timeout():
	get_tree().change_scene("res://Label.tscn")
	