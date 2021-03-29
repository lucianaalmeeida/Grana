extends CanvasLayer

var proximoCaminho

func fade_to(path):
	proximoCaminho = path
	get_node("Anim").play("Fade")

func change_scene():
	if proximoCaminho != null:
		get_tree().change_scene(proximoCaminho)