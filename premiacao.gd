extends Node
#VARIÁVEIS
var estado
var quantPerg
var totalMoedas = game.acertou * 200
var total = totalMoedas - game.countDicas

#Instaciando os nodes
onready var msg = get_node("msg")
onready var cabecalho = get_node("cabecalho")
onready var comprar = get_node("comprar")
onready var comprarL = get_node("comprarL")
onready var poupar = get_node("poupar")
onready var pouparL = get_node("pouparL")
onready var ok = get_node("ok")
onready var okL = get_node("okL")
onready var timer1 = get_node("Timer1")
onready var timer2 = get_node("Timer2")
onready var timer3 = get_node("Timer3")
onready var timer4 = get_node("Timer4")

func _ready():
	#Verifica se o jogador ganhou ou perdeu de acordo com a quantidade de perguntas respondidas corretamente em cada nível
	if game.nivelAtual == 1:
		if game.acertou == 2 and game.nivel == 1:
			estado = "ganhou"
			ganhou(2)
		else:
			estado = "perdeu"
			ganhou(1)
	elif game.nivelAtual == 2:
		if (game.acertou == 3 or game.acertou >= 2) and game.nivel == 2:
			estado = "ganhou"
			ganhou(3)
		else:
			estado = "perdeu"
			ganhou(2)
	elif game.nivelAtual == 3:
		if (game.acertou == 5 or game.acertou >= 3) and game.nivel == 3:
			estado = "ganhou"
			ganhou(4)
		else:
			estado = "perdeu"
			ganhou(3)
	elif game.nivelAtual == 4:
		if (game.acertou == 8 or game.acertou >= 5) and game.nivel == 4:
			estado = "ganhou"
			ganhou(5)
		else:
			estado = "perdeu"
			ganhou(4)
	elif game.nivelAtual == 5:
		if game.acertou >= 8 and game.nivel == 5:
			estado = "ganhou"
			ganhou(6)
		else:
			estado = "perdeu"
			ganhou(5)
	game.acertou = 0

#Função executada quando o jogador termina o nível
func ganhou(nivel):
	#Verifica se o nível é menor ou igual a nível atual e atribui o nível 
	if game.nivel <= game.nivelAtual:
		game.nivel = nivel
		game.nivelAtual = nivel
	#Verifica se o jogador passou de nível, se apenas ganhou moedas e gastou com ajudas e ou não ganhou nenhuma moeda 
	if game.nivel < 6 and estado == "ganhou":
		ok.show()
		okL.show()
		msg.set_text("Você está no nível "+str(game.nivel)+"!!")
		game.nivelModif = true
	elif game.nivel == 6 and game.ganhou == false:
		ok.show()
		okL.show()
		cabecalho.set_text("Parabéns!") 
		msg.set_text("Você ganhou "+str(total)+" moedas!")
		estado = "terminou"
	elif total == 0 or game.score == 0:
		nenhumaMoeda()
	else: 
		premiacao()

#Função executada quando o jogador não ganhou nenhuma moeda
func nenhumaMoeda():
	ok.show()
	okL.show()
	cabecalho.set_text("Infelizmente!") 
	msg.set_text("Você não conseguiu nenhuma moeda.\nTente Novamente!")
	estado = "perdeu"

#Função executada quando o jogador pressiona o botão de comprar 
func _on_comprar_pressed():
	timer1.start()
	timer1.connect("timeout", self, "on_timeout_comprar")

func on_timeout_comprar():
	estado = "comprar"
	acabou()

#Função executada quando o jogador pressiona o botão de poupar
func _on_poupar_pressed():
	timer2.start()
	timer2.connect("timeout", self, "on_timeout_poupar")

func on_timeout_poupar():
	estado = "poupar"
	acabou()

#Função executada quando jogador clicar em poupar ou comprar
func acabou():
	get_node("click").play()
	timer3.start()
	timer3.connect("timeout", self, "on_timeout_completo")

func on_timeout_completo():
	game.poupanca = game.score + game.poupanca #Atribui o valor em moedas adquirido no nível para a poupança do Banco
	game.countDicas = 0
	#Verifica se o jogador pressionou poupar ou comprar ou se o jogador finalizou o jogo e muda para a cena mais adequada
	if estado == "comprar":
		game.mudar_scene("res://scenes/loja.tscn")
	elif estado == "poupar" or estado == "perdeu":
		game.mudar_scene("res://scenes/niveis.tscn")
	elif estado == "terminou":
		game.mudar_scene("res://scenes/final.tscn")

#Função Botão Ok
func _on_ok_pressed():
	timer4.start()
	timer4.connect("timeout", self, "on_timeout_ok")

func on_timeout_ok():
	get_node("click").play()
	if estado == "perdeu":
		acabou()
	elif estado == "terminou":
		acabou()
	else:
		get_node("click").play()
		ok.hide()
		okL.hide()
		premiacao()

#Função executada quando o jogador gastou suas moedas com alguma ajuda ou se apenas conseguiu moedas e já tinha passado este nível, ou seja, está jogando novamente o nível 
func premiacao():
	comprar.show()
	comprarL.show()
	poupar.show()
	pouparL.show()
	if game.countDicas > 0:
		msg.set_text("Você ganhou "+str(totalMoedas)+" moedas!\nMas gastou "+str(game.countDicas)+" em ajudas e teve como saldo "+str(total)+"!\nO que você deseja fazer com suas moedas?")
	else:
		msg.set_text("Você ganhou "+str(total)+" moedas!\nO que você deseja fazer com suas moedas?")