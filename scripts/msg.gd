extends Node

onready var timer = get_node("Timer")

func _on_ok_pressed():
	get_node("click").play()
	timer.start()
	timer.connect("timeout", self, "on_timeout_completo")

func on_timeout_completo():
	if game.cenaAtual == "perguntas":
		game.poupanca = game.score + game.poupanca
		game.contador = 0
		game.acertou = 0

	transition.fade_to("res://scenes/niveis.tscn")
