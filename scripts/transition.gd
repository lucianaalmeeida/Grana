extends Node

#VARIÁVEIS
var num = 0
#Instaciando os nodes
onready var timer = get_node("Timer")
onready var tempo = get_node("mediacao/Timer")
onready var okT = get_node("mediacao/ok")
onready var premio = get_node("premio")
onready var premioL = get_node("premioL")
onready var preco = get_node("preco")
onready var click = get_node("click-buttom")

func _ready():
	game.cenaAtual = "loja"
	game.comprou = false
	imprimir(num) 
	set_process(true)

func _process(delta):
	#Verifica se jogador possui moedas suficientes para comprar o prêmio ou se já o adquiriu
	if game.poupanca < game.premios[num][1]: #IMAGEM BLOQUEADO
		get_node("comprar").set_texture(load("res://sprites/comprarButtom-press.png"))
	elif game.premios[num][2] == false: #IMAGEM DESBLOQUEADO
		get_node("comprarL").set_text("Comprar")
		get_node("comprar").set_texture(load("res://sprites/comprarButtom.png"))
	if game.premios[num][2] == true:
		premioAdquirido()

#Função executada quando o prêmio foi adquirido
func premioAdquirido(): 
	get_node("comprarL").set_text("Adquirido")
	get_node("comprar").set_texture(load("res://sprites/comprarButtom.png"))

#Função executada quando o jogador clicar em próximo
func _on_proximo_pressed():
	click.play()
	get_node("comprarL").set_text("Comprar")
	if num < (game.premios.size() - 1):
		num += 1
		imprimir(num)

#Função executada quando o jogador clicar em anterior
func _on_anterior_pressed():
	click.play()
	get_node("comprarL").set_text("Comprar")
	if num > 0: 
		if num <= (game.premios.size() - 1):
			num -= 1
			imprimir(num)

#Função executada quando jogador clicar no Botão de pressionar
func _on_comprar_pressed():
	click.play()
	game.comprou = true
	if game.poupanca >= game.premios[num][1] and game.premios[num][2] == false:
		get_node("mediacao/texto").set_text("Você deseja realmente comprar este item? ")
		aparecerSimNao()
	elif game.poupanca < game.premios[num][1] and game.premios[num][2] == false:
		aparecerOk()
		get_node("mediacao/texto").set_text("Infelizmente, você não possui moedas suficientes!")
	else:
		aparecerOk()
		get_node("mediacao/texto").set_text("Você já adquiriu este item!")

#Função para aparecer a mensagem com a opção de sim e não
func aparecerSimNao():
	get_node("mediacao/sombra").show()
	get_node("mediacao/fundo").show()
	get_node("mediacao/titulo").show()
	get_node("mediacao/texto").show()
	get_node("mediacao/sim").show()
	get_node("mediacao/nao").show()

#Função para desaparecer a mensagem com a opção de sim e não
func desaparecerSimNao():
	tempo.start()
	tempo.connect("timeout", self, "_on_timeout_nao")

func _on_timeout_nao():
	get_node("mediacao/sombra").hide()
	get_node("mediacao/fundo").hide()
	get_node("mediacao/titulo").hide()
	get_node("mediacao/texto").hide()
	get_node("mediacao/sim").hide()
	get_node("mediacao/nao").hide()

#Função para aparecer a mensagem com a opção de ok
func aparecerOk():
	get_node("mediacao/sombra").show()
	get_node("mediacao/fundo").show()
	get_node("mediacao/titulo").show()
	get_node("mediacao/texto").show()
	get_node("mediacao/ok").show()

#Função para desaparecer a mensagem com a opção de ok
func desaparecerOk():
	tempo.start()
	tempo.connect("timeout", self, "_on_timeout_ok")

func _on_timeout_ok():
	get_node("mediacao/sombra").hide()
	get_node("mediacao/fundo").hide()
	get_node("mediacao/titulo").hide()
	get_node("mediacao/texto").hide()
	get_node("mediacao/ok").hide()

#Função para imprimir os prêmios e o seu preço na tela 
func imprimir(num):
	premio.set_texture(load("res://sprites/"+str(game.premios[num][0])+".png"))
	if game.premios[num][0] == game.premios[0][0]:
		premioL.set_text("Celular")
	elif game.premios[num][0] == game.premios[1][0]:
		premioL.set_text("Videogame")
	elif game.premios[num][0] == game.premios[2][0]:
		premioL.set_text("Televisão")
	elif game.premios[num][0] == game.premios[3][0]:
		premioL.set_text("Notebook")
	elif game.premios[num][0] == game.premios[4][0]:
		premioL.set_text("Viagem")
	preco.set_text(str(game.premios[num][1]))

#Função executada quando jogador clicar em sim
func _on_sim_pressed():
	click.play()
	if game.poupanca >= game.premios[num][1]:
		game.poupanca = game.poupanca - game.premios[num][1]
		game.premios[num][2] = true
		game.save()
		desaparecerSimNao()
		get_node("Anim").play("moedas")
		get_node("Mmoedas").play()

#Função executada quando o jogador clicar em não
func _on_nao_pressed():
	click.play()
	desaparecerSimNao()

#Função executada quando o clicar em ok
func _on_ok_pressed():
	click.play()
	desaparecerOk()