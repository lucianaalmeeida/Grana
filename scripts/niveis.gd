extends Node

#VARIÁVEIS
var timer1
var timer2
var timer3
var tempo

func _ready():
	game.cenaAtual = "niveis" #ATRIBUE CENA ATUAL PARA VARIÁVEL GLOBAL
	game.score = 0 #SETA O VALOR DOS PONTOS PARA ZERO
	#INSTACIA OS TIMERS
	timer1 = get_node("Timer1")
	timer2 = get_node("Timer2")
	timer3 = get_node("Timer3")
	tempo = get_node("mediacao/Timer")
	#ESTRUTURA DE SELEÇÃO PARA OS NÍVEIS SEREM DESBLOQUEADOS E APARECER O
	#PERSONAGEM NO NÍVEL ONDE O JOGADOR SE ENCONTRA
	if game.nivel >= 1:
		if game.nivelModif == true:
			get_node("Anim").play("n"+str(game.nivel))
			game.nivelModif = false
		else:
			if game.nivelAtual <= 5 and game.nivelAtual >= 1:
				get_node("Anim").play("n"+str(game.nivelAtual))
			elif game.nivel == 6:
				get_node("Anim").play("n"+str(game.nivel-1))
			else:
				get_node("Anim").play("n"+str(game.nivel))
		# Aqui se encontra a estrutura de seleção para desbloquear os níveis quando
		# o jogador passar de nível
		if game.nivel == 2:
			aparecerNiveis(3)
		elif game.nivel == 3:
			aparecerNiveis(4)
		elif game.nivel == 4:
			aparecerNiveis(5)
		elif game.nivel == 5 or game.nivel == 6:
			aparecerNiveis(6)

#FUNÇÕES PARA DETERMINAR O NÍVEL QUE O JOGADOR SE ENCONTRA
func _on_Nivel1_pressed():
	nivelPress(1)

func _on_Nivel2_pressed():
	nivelPress(2)

func _on_Nivel3_pressed():
	nivelPress(3)

func _on_Nivel4_pressed():
	nivelPress(4)

func _on_Nivel5_pressed():
	nivelPress(5)

#FUNÇÃO QUE SERÁ EXECUTADA QUANDO UM NÍVEL FOR PRESSIONADO
func nivelPress(nivel):
	get_node("click").play()
	#Verifica se o nível está bloqueado, se sim aparece uma mensagem 
	#informando que o nível está bloqueado
	if game.nivel >= nivel: 
		timer1.start()
		timer1.connect("timeout", self, "on_timeout_complete")
		game.nivelAtual = nivel
	else:
		aparecerOk()

func on_timeout_complete():
	game.mudar_scene("res://scenes/valendo.tscn")

#Função para aparecer a mensagem informando que o nível está bloqueado
func aparecerOk():
	get_node("mediacao/sombra").show()
	get_node("mediacao/fundo").show()
	get_node("mediacao/titulo").show()
	get_node("mediacao/texto").show()
	get_node("mediacao/ok").show()

#Função para desaparecer a mensagem
func desaparecerOk():
	get_node("mediacao/sombra").hide()
	get_node("mediacao/fundo").hide()
	get_node("mediacao/titulo").hide()
	get_node("mediacao/texto").hide()
	get_node("mediacao/ok").hide()

#Função para desbloquear os níveis de acordo com nível do jogador
#BAÚ ABERTO
func aparecerNiveis(num):
	for i in range(1, num):
		get_node("Nivel"+str(i)).set_texture(load("res://sprites/nivel-novo.png"))
#		get_node("Nivel"+str(i)).set_texture_pressed(load("res://sprites/nivel-press.png"))
	if game.nivel == 6:
		apareceNivel(game.nivel-1)
	else:
		apareceNivel(game.nivel)

#Função para setar a imagem do nível quando ele ainda não estiver sido clicado
#BAÚ FECHADO MAS COLORIDO 
func apareceNivel(num):
	get_node("Nivel"+str(num)).set_texture(load("res://sprites/nivel.png"))
#	get_node("Nivel"+str(num)).set_texture_pressed(load("res://sprites/nivel-novo-press.png"))

#FUNÇÃO PARA SER EXECUTADA QUANDO O BOTÃO LOJA FOR PRESSIONADO
func _on_loja_pressed():
	get_node("click").play()
	timer2.start()
	timer2.connect("timeout", self, "on_timeout_completo")

func on_timeout_completo():
	transition.fade_to("res://scenes/loja.tscn")

#FUNÇÃO QUE SERÁ EXECUTADA O BOTÃO VOLTAR FOR PRESSIONADO
func _on_menu_pressed():
	get_node("click").play()
	timer3.start()
	timer3.connect("timeout", self, "on_timeout_menu")

func on_timeout_menu():
	transition.fade_to("res://scenes/menu.tscn") #MUDA PARA A CENA DE MENU

#FUNÇÃO DO BOTÃO OK DA MENSAGEM DE NÍVEL BLOQUEADO
func _on_ok_pressed():
	get_node("click").play()
	tempo.start()
	tempo.connect("timeout", self, "on_timeout_ok")

func on_timeout_ok():
	desaparecerOk() #DESAPARECE A MENSAGEM
