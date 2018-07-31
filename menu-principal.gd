extends Node

#VARIÁVEIS
var timer
var tempo
onready var click = get_node("click-buttom")

#FUNÇÕES
func _ready():
	game.cenaAtual = "menu" 
	#Instaciando Nodes
	timer = get_node("Timer") 
	tempo = get_node("mediacao/Timer")
	set_process(true) #Permite que a função _process execute seu conteúdo sempre

func _process(delta):
	#Verifica se o jogador escolheu um personagem, ou seja, se ele já iniciou 
	#alguma vez o jogo então irá ser apresentado o botão continuar, se não o 
	#botão não vai aparecer
	if game.sexo == "F" or game.sexo == "M":
		get_node("continuar").show()
		get_node("continuarL").show()
	else:
		get_node("continuar").hide()
		get_node("continuarL").hide()

#Função do botão continuar
func _on_continuar_pressed():
	click.play()
	timer.start()
	timer.connect("timeout", self, "on_timeout_continuar")

#Muda para a cena Níveis
func on_timeout_continuar():
	game.mudar_scene("res://scenes/niveis.tscn")

#Função do botão Jogar
func _on_jogar_pressed():
	click.play()
	timer.start()
	timer.connect("timeout", self, "on_timeout_jogar")

#Verifica se o jogador já iniciou o jogo se sim irá aprecer um diálogo 
#perguntando se deseja apagar todo o progresso no jogo, se não o jogador
#será apresentado a cena de apresentação 
func on_timeout_jogar():
	if game.sexo == "":
		game.mudar_scene("res://scenes/apresentacao.tscn")
	else: 
		desativarCena()
		aparecerDialogo()

#Função do Botão da Loja
func _on_loja_pressed():
	click.play()
	timer.start()
	timer.connect("timeout", self, "on_timeout_loja")

#Muda para a cena da Loja
func on_timeout_loja():
	game.mudar_scene("res://scenes/loja.tscn")

#Função do Botão Sobre
func _on_sobre_pressed():
	click.play()
	timer.start()
	timer.connect("timeout", self, "on_timeout_sobre")

#Muda para a cena de Sobre
func on_timeout_sobre():
	game.mudar_scene("res://scenes/sobre.tscn")

#Função para desativar todos os botões para que o jogador não consiga clicar
func desativarCena():
	get_node("continuar").set_process_input(false)
	get_node("jogar").set_process_input(false)
	get_node("loja").set_process_input(false)
	get_node("sobre").set_process_input(false)

#Função para ativar todos os botões
func ativarCena():
	get_node("continuar").set_process_input(true)
	get_node("jogar").set_process_input(true)
	get_node("loja").set_process_input(true)
	get_node("sobre").set_process_input(true)

#Função para aparecer uma mensagem de confirmação se deseja 
#apagar todo o progresso no jogo
func aparecerDialogo():
	get_node("mediacao/sombra").show()
	get_node("mediacao/fundo").show()
	get_node("mediacao/titulo").show()
	get_node("mediacao/texto").show()
	get_node("mediacao/sim").show()
	get_node("mediacao/nao").show()

#Função desaparecer a mensagem de confirmação
func desaparecerDialogo():
	get_node("mediacao/sombra").hide()
	get_node("mediacao/fundo").hide()
	get_node("mediacao/titulo").hide()
	get_node("mediacao/texto").hide()
	get_node("mediacao/sim").hide()
	get_node("mediacao/nao").hide()

#Função do Botão sim da mensagem de confirmação
func _on_sim_pressed():
	click.play() #Toca o som do click do botão
	tempo.start() #Inicia o tempo para aparecer o efeito de click do botão
	tempo.connect("timeout", self, "on_timeout_sim") #Quando o tempo de click do botão acabar será chamada a função on_timeout_sim 

func on_timeout_sim():
	game.delete() #Retorna o jogo para o estado padrão
	game.mudar_scene("res://scenes/apresentacao.tscn") #Muda para a cena de apresentação

#Função do Botão não quando for pressionado
func _on_nao_pressed():
	click.play()
	tempo.start()
	tempo.connect("timeout", self, "on_timeout_nao")

func on_timeout_nao():
	ativarCena()
	desaparecerDialogo()