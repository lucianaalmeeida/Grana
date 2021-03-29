extends TouchScreenButton
#VARIÁVEIS
#Instanciando os nodes
onready var timer = get_node("Timer")
onready var click = get_node("click") 

#Função executada quando o botão sair é pressionado 
func _on_sair_pressed():
	click.play()
	timer.start()
	timer.connect("timeout", self, "on_timeout_complete")

func on_timeout_complete():
	#Verifica qual cena o jogador se encontra para mudar para a cena adequada
	if game.cenaAtual == "niveis":
		transition.fade_to("res://scenes/niveis.tscn")
	elif game.cenaAtual == "menu":
		transition.fade_to("res://scenes/menu.tscn")
	elif game.cenaAtual == "perguntas" or game.cenaAtual == "loja":
		if game.score > 0 and game.comprou == false:
			game.mudar_scene("res://scenes/msg.tscn")
		else:
			transition.fade_to("res://scenes/niveis.tscn")