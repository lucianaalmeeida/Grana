extends CanvasLayer

var proximoCaminho

func _ready():
	fade_to()

func fade_to():
	proximoCaminho = "res://scenes/logo.tscn"
	get_node("Anim").play("Fade")

func change_scene():
	if proximoCaminho != null:
		get_tree().change_scene(proximoCaminho)