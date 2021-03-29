extends Node
#VARIAVEL
var j = 1
func _ready():
	game.ganhou = true #FINALIZOU O JOGO
	game.save() #SALVA O ESTADO DO JOGO
	#IMPRIME O NUMERO DE ACERTOS, ERROS E A QUANTIDADE DE MOEDAS TOTAL
	get_node("texto").set_text("Número de acertos: "+str(game.acertos)+"\nNúmero de erros: "+str(game.erros)+"\nValor acumulado: "+str(game.poupanca)) 
	#APRESENTA OS PRÊMIOS QUE JOGADOR COMPROU
	for i in range(game.premios.size()):
		if game.premios[i][2] == true:
			get_node("premio"+str(j)).set_texture(load("res://sprites/"+str(game.premios[i][0])+".png"))
			j += 1
	get_node("AnimationPlayer").play("play")

#FUNÇÃO PARA MUDAR PARA CENA DE SOBRE
func _on_buttom_pressed():
	get_node("click").play()
	get_node("Timer").start()
	get_node("Timer").connect("timeout", self, "on_timeout_buttom")

func on_timeout_buttom():
	game.mudar_scene("res://scenes/sobre.tscn")