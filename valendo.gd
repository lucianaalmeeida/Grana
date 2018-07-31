extends Label

func _ready():
	#Verifica quanto o jogador pode ganhar em moedas em cada nível
	if game.nivelAtual == 1:
		game.preco = 400
	elif game.nivelAtual == 2:
		game.preco = 600
	elif game.nivelAtual == 3:
		game.preco = 1000
	elif game.nivelAtual == 4:
		game.preco = 1600
	elif game.nivelAtual == 5:
		game.preco = 2600
	set_text("Valendo "+str(game.preco)+" moedas!!") #Imprime

#Função é executada quando o tempo de execução da cena esgotar
func _on_Timer_timeout():
	game.mudar_scene("res://scenes/perguntas.tscn") #Muda para a cena das perguntas
