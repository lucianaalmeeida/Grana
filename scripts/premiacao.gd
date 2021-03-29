extends Node
#VARIÁVEIS
var estado
var nivel = game.nivelAtual
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
onready var moeda1 = get_node("moeda1")
onready var moeda2 = get_node("moeda2")
onready var moeda3 = get_node("moeda3")
onready var sprite = get_node("Sprite")
onready var nivelL = get_node("nivelL")

func _ready():
	#Exibe nível atual que o jogador está jogando
	get_node("nivelL").set_text("NÍVEL "+str(int(game.nivelAtual)))
	#Verifica se o jogador ganhou ou perdeu de acordo com a quantidade de perguntas respondidas corretamente em cada nível
	if game.nivelAtual == 1:
		if game.acertou == 2 and game.nivel == 1:
			estado = "ganhou"
			resultado(2)
		else:
			estado = "perdeu"
			resultado(1)
	elif game.nivelAtual == 2:
		if (game.acertou == 3 or game.acertou >= 2) and game.nivel == 2:
			estado = "ganhou"
			resultado(3)
		else:
			estado = "perdeu"
			resultado(2)
	elif game.nivelAtual == 3:
		if (game.acertou == 5 or game.acertou >= 3) and game.nivel == 3:
			estado = "ganhou"
			resultado(4)
		else:
			estado = "perdeu"
			resultado(3)
	elif game.nivelAtual == 4:
		if (game.acertou == 8 or game.acertou >= 5) and game.nivel == 4:
			estado = "ganhou"
			resultado(5)
		else:
			estado = "perdeu"
			resultado(4)
	elif game.nivelAtual == 5:
		if game.acertou >= 8 and game.nivel == 5:
			estado = "ganhou"
			resultado(6)
		else:
			estado = "perdeu"
			resultado(5)
	set_process(true)

#Esta função ficará sendo executada durante todo o tempo que esta cena 
#estiver ativa
func _process(delta):
	if game.nivelModif == false: #verifica se o jogador não passou de nível
		verificaMoeda() #Verifica a quantidade de 'Estrelas' o jogador ganhou

func verificaMoeda():
	if nivel == 1:
		if game.acertou <= 0:
			aparecerMoedas(1)
		elif game.acertou == 1:
			aparecerMoedas(2)
		elif game.acertou == 2:
			aparecerMoedas(3)
	elif nivel == 2:
		if game.acertou <= 1:
			aparecerMoedas(1)
		elif game.acertou == 2:
			aparecerMoedas(2)
		elif game.acertou == 3:
			aparecerMoedas(3)
	elif nivel == 3:
		if game.acertou <= 1:
			aparecerMoedas(1)
		elif game.acertou <= 3:
			aparecerMoedas(2)
		elif game.acertou <= 5:
			aparecerMoedas(3)
	elif nivel == 4:
		if game.acertou <= 1:
			aparecerMoedas(1)
		elif game.acertou <= 4:
			aparecerMoedas(2)
		elif game.acertou <= 8:
			aparecerMoedas(3)
	elif nivel == 5:
		if game.acertou <= 1:
			aparecerMoedas(1)
		elif game.acertou <= 7:
			aparecerMoedas(2)
		elif game.acertou <= 13:
			aparecerMoedas(3)
	game.acertou = 0

#Esta função mostra na tela as moedas que o jogador ganhou
func aparecerMoedas(num):
	if num == 1:
		moeda1.show() #torna visível o sprite
	elif num == 2:
		moeda1.show()
		moeda2.show()
	elif num == 3:
		moeda1.show()
		moeda2.show()
		moeda3.show()

#Função executada quando o jogador termina o nível

func resultado(nivel):
	#Verifica se o nível é menor ou igual a nível atual e atribui o nível 
	if game.nivel <= game.nivelAtual:
		game.nivel = nivel
		game.nivelAtual = nivel
	#Verifica se o jogador passou de nível, se apenas ganhou moedas e gastou com ajudas e ou não ganhou nenhuma moeda 
	if game.nivel < 6 and estado == "ganhou":
		sprite.hide() #torna invisivel o sprite
		nivelL.hide()
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
	timer1.start() #Inicia o timer
	timer1.connect("timeout", self, "on_timeout_comprar") #Faz uma conexão com uma função para ser executada quando o timer acabar

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
	get_node("click").play() #Executa o clique do botão
	timer3.start()
	timer3.connect("timeout", self, "on_timeout_completo")

func on_timeout_completo():
	game.poupanca = game.score + game.poupanca #Atribui o valor em moedas adquirido no nível para a poupança do Banco
	game.pontuacaoTotal = game.poupanca
	game.loja = true
	game.countDicas = 0
	#Verifica se o jogador pressionou poupar ou comprar ou se o jogador finalizou o jogo e muda para a cena mais adequada
	if estado == "comprar":
		transition.fade_to("res://scenes/loja.tscn")
	elif estado == "poupar" or estado == "perdeu":
		transition.fade_to("res://scenes/niveis.tscn")
	elif estado == "terminou":
		transition.fade_to("res://scenes/final.tscn")

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
		verificaMoeda()
		sprite.show()
		nivelL.show()
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