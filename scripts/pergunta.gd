extends Node

#VARIÁVEIS
var pergs
var itens
var qRespondida
var ajuda
var tempo
var ajudaBloq = 0
var precoAjuda = 0 
var dica = false
var pular = false 
var mais_tempo = false 
var tesoura = false

#Instaciando nodes
onready var titulo = get_node("Ajudas/mediacao/titulo")
onready var texto = get_node("Ajudas/mediacao/texto")
onready var sim = get_node("Ajudas/mediacao/sim")
onready var nao = get_node("Ajudas/mediacao/nao")
onready var timer = get_node("Timer")
onready var timerT = get_node("pergTempo")
onready var buttom1 = get_node("Buttom1")
onready var buttom2 = get_node("Buttom2")
onready var buttom3 = get_node("Buttom3")
onready var buttom4 = get_node("Buttom4")
var musica1 = false
var musica2 = false
var musica3 = false
func _ready():
	game.cenaAtual = "perguntas"
	get_node("NivelL").set_text("Nível "+ str(int(game.nivelAtual)))
	embaralharPerg(game.arrayPergunta[game.nivelAtual-1]) #Embaralha as perguntas de acordo com nível
	imprimir((game.nivelAtual-1), pergs, itens) #Imprime a pergunta selecionada e os seus itens 
	set_process(true) #Torna possível a função _process ser executada 

func toca_musica():
	if musica1 == false: 
		if int(timerT.get_time_left()) <= 10:
			get_node("Mfundo").set_stream(load("res://music/10-segundos.ogg"))
			get_node("Mfundo").play()
			musica1 = true
			musica2 = false
			musica3 = false
	if musica2 == false:
		if int(timerT.get_time_left()) > 10:
			get_node("Mfundo").set_stream(load("res://music/audio-fundo.ogg"))
			get_node("Mfundo").play()
			musica2 = true
			musica1 = false
			musica3 = false
	if musica3 == false:
		if int(timerT.get_time_left()) == 0 and timerT.is_processing():
			get_node("Srelogio").play()
			musica3 = true
	if int(timerT.get_time_left()) == 0:
		get_node("Mfundo").stop()

func _process(delta):
	#Imprime o tempo para responder a pergunta
	if int(timerT.get_time_left()) > 0:
		get_node("TempoL").set_text(str(int(timerT.get_time_left())))
	else:
		get_node("TempoL").set_text("")
	toca_musica()
	verificaAcertou() #Verifica se o jogador acertou a pergunta
	#Verifica se a pergunta foi respondida e recarrega a página
	if qRespondida == true: 
		set_process(false)
		game.contador += 1
		recarregar()
		qRespondida = false
		game.nivelTerminou = false
		game.countPular += 1
	#Verifica se jogador possui moedas suficientes para comprar as ajudas seja as moedas que
	#adiquiriu no nível respondendo as perguntas ou as que possui no Banco e se o jogador já 
	#comprou todas as ajudas disponíveis por pergunta e as bloqueia
	if (game.score < game.valorDica and game.poupanca < game.valorDica) or game.cDica == 1:
		bloqAjuda(1)
	if game.score < game.valorTempo and game.poupanca < game.valorTempo:
		bloqAjuda(3)
	if (game.score < game.valorTesoura and game.poupanca < game.valorTesoura) or game.cTesoura == 3:
		bloqAjuda(4)
	if game.score < game.valorPular and game.poupanca < game.valorPular or game.cPular == 1:
		bloqAjuda(2)
	#Verifica se a pergunta foi respondida e seta os valores padrões para as variáveis de controle
	if game.countPular == 1:
		game.cDica = 0
		game.cTesoura = 0
		game.cPular = 0
		dica = false
		pular = false
		mais_tempo = false
		tesoura = false
		game.countPular = 0

#Função para bloquear uma ajuda específica 
func bloqAjuda(num):
	ajudaBloq = num
	if ajudaBloq == 1: #DICA
		dica = true
		get_node("Ajudas/ajuda1").set_texture(load("res://sprites/BdicaBloq.png"))
#		get_node("Ajudas/ajuda1").set_texture_pressed(load("res://sprites/buttom1-press.png"))
	elif ajudaBloq == 2: #PULAR
		pular = true
		get_node("Ajudas/ajuda2").set_texture(load("res://sprites/BpularBloq.png"))
#		get_node("Ajudas/ajuda2").set_texture_pressed(load("res://sprites/buttom1-press.png"))
	elif ajudaBloq == 3: #+TEMPO
		mais_tempo = true
		get_node("Ajudas/ajuda3").set_texture(load("res://sprites/BtempoBloq.png"))
#		get_node("Ajudas/ajuda3").set_texture_pressed(load("res://sprites/buttom1-press.png"))
	elif ajudaBloq == 4: #ELIMINA UM ITEM
		tesoura = true
		get_node("Ajudas/ajuda4").set_texture(load("res://sprites/BeliminarBloq.png"))
#		get_node("Ajudas/ajuda4").set_texture_pressed(load("res://sprites/buttom1-press.png"))

#Função para recarregar a cena
func recarregar():
	timer.start()
	timer.connect("timeout", self, "on_timeout_complete")

func on_timeout_complete():
	#Verifica se o nível terminou, se não recarrega a cena, 
	#se sim marca todas as perguntas como false para que elas 
	#possam ser sorteadas novamente quando jogador iniciar este nível
	if game.nivelTerminou == false:
		get_node("Anim").play("reload")
		game.mudar_scene("res://scenes/perguntas.tscn")
	else:
		for i in range(game.arrayPergunta[game.nivelAtual-1].size()):
			game.arrayPergunta[game.nivelAtual-1][i][3] = false
		transition.fade_to("res://scenes/premiacao.tscn")

#Função para sortear uma pergunta
func embaralharPerg(perg):
	randomize()
	var x = randi()%perg.size()
	testaNumPerg(x)

#Função para verificar se o número da pergunta corresponde a uma pergunta 
#ainda não respondida
func testaNumPerg(num):
	if game.arrayPergunta[game.nivelAtual-1][num][3] == false:
		pergs = num
		embaralharItens(range(game.arrayPergunta[game.nivelAtual-1][pergs][1].size()))
	else:
		embaralharPerg(game.arrayPergunta[game.nivelAtual-1])

#Função para embaralhar os itens da pergunta selecionada ele retorna uma lista
#dos itens embaralhados
func embaralharItens(lista):
	var listaEmbaralhada = []
	var x
	for i in range(lista.size()):
		randomize()
		x = randi()%lista.size()
		listaEmbaralhada.append(lista[x])
		lista.remove(x)
	itens = listaEmbaralhada

#Função para imprimir na tela a pergunta e os seus itens selecionados
func imprimir(nivel, numP, numI):
	get_node("Anim").play("load")
	get_node("PerguntaL").set_text(str(game.arrayPergunta[nivel][numP][0]))
	get_node("Buttom1/Item1").set_text(str(game.arrayPergunta[nivel][numP][1][numI[0]]))
	get_node("Buttom2/Item2").set_text(str(game.arrayPergunta[nivel][numP][1][numI[1]]))
	get_node("Buttom3/Item3").set_text(str(game.arrayPergunta[nivel][numP][1][numI[2]]))
	get_node("Buttom4/Item4").set_text(str(game.arrayPergunta[nivel][numP][1][numI[3]]))

#Função para verificar e apresentar se o jogador acertou uma pergunta
func verificaAcertou():
	#Instaciando os nodes
	var buttom1 = get_node("Buttom1")
	var buttom2 = get_node("Buttom2")
	var buttom3 = get_node("Buttom3")
	var buttom4 = get_node("Buttom4")
	var item1 = get_node("Buttom1/Item1").get_text()
	var item2 = get_node("Buttom2/Item2").get_text()
	var item3 = get_node("Buttom3/Item3").get_text()
	var item4 = get_node("Buttom4/Item4").get_text()
	var correto = preload("res://sprites/item-verde.png") #Imagem do Botão Correto
	var errado = preload("res://sprites/item-vermelho.png") #Imagem do Botão Errado
	var qCorreta = game.arrayPergunta[game.nivelAtual-1][pergs][1][0] #O item correto é o primeiro índice de cada pergunta
	
	#Verifica se acertou ou errou e muda a textura do botão de acordo com o resultado
	if qCorreta == item1 and buttom1.is_pressed():
		buttom1.set_texture(correto)
		acertou()
	elif qCorreta == item2 and buttom2.is_pressed():
		buttom2.set_texture(correto)
		acertou()
	elif qCorreta == item3 and buttom3.is_pressed():
		buttom3.set_texture(correto)
		acertou()
	elif qCorreta == item4 and buttom4.is_pressed():
		buttom4.set_texture(correto)
		acertou()
	elif qCorreta != item1 and buttom1.is_pressed(): 
			buttom1.set_texture(errado)
			if qCorreta == item2:
				buttom2.set_texture(correto)
			elif qCorreta == item3:
				buttom3.set_texture(correto)
			elif qCorreta == item4:
				buttom4.set_texture(correto)
			errou()
	elif qCorreta != item2 and buttom2.is_pressed(): 
			buttom2.set_texture(errado)
			if qCorreta == item1:
				buttom1.set_texture(correto)
			elif qCorreta == item3:
				buttom3.set_texture(correto)
			elif qCorreta == item4:
				buttom4.set_texture(correto)
			errou()
	elif qCorreta != item3 and buttom3.is_pressed(): 
			buttom3.set_texture(errado)
			if qCorreta == item1:
				buttom1.set_texture(correto)
			elif qCorreta == item2:
				buttom2.set_texture(correto)
			elif qCorreta == item4:
				buttom4.set_texture(correto)
			errou()
	elif qCorreta != item4 and buttom4.is_pressed(): 
			buttom4.set_texture(errado)
			if qCorreta == item1:
				buttom1.set_texture(correto)
			elif qCorreta == item2:
				buttom2.set_texture(correto)
			elif qCorreta == item3:
				buttom3.set_texture(correto)
			errou()

#Função que é executada quando o jogador acerta uma pergunta
func acertou():
	qRespondida = true
	game.score += 200
	get_node("Anim").play("moedas")
	get_node("Acertou").set_text("Acertou")
	game.acertou += 1
	game.acertos += 1
	game.arrayPergunta[game.nivelAtual-1][pergs][3] = true 
#	print(game.arrayPergunta[game.nivelAtual-1][pergs][3])

#Função que é executada quando o jogador erra uma pergunta
func errou():
	game.erros += 1
	qRespondida = true
	get_node("Errou").set_text("Errou")

#Função que é executada quando o tempo para responder uma pergunta se esgota
func _on_pergTempo_timeout():
	game.nivelTerminou = false
	game.contador += 1
	get_node("TempoL").set_text("")
	get_node("TempoEsgotado").set_text("Tempo Esgotado!!")
	recarregar()

#Função para verificar se o jogador possui moedas suficientes para comprar ajudas
func verificaDinheiro(preco):
	precoAjuda = preco
	if game.score >= preco: 
		aparecerAjuda()
	elif game.poupanca >= preco: 
		aparecerSimNao()
		desativaCena()
		get_node("Ajudas/mediacao/titulo").set_text("Atenção!")
		get_node("Ajudas/mediacao/texto").set_text("Infelizmente você não possui moedas, você deseja retirar moedas do Banco?")
	else:
		alerta()

#FUNÇÕES QUE SÃO EXECUTADAS QUANDO OS BOTÕES DAS AJUDAS É PRESSIONADO
#CASO A AJUDA SEJA IGUAL A TRUE A AJUDA ESTÁ BLOQUEADA SE NÃO ELA É EXECUTADA
func _on_ajuda1_pressed():
	if dica == true:
		bloqueada()
	else:
		ajuda = "dicas"
		get_node("click").play()
		verificaDinheiro(game.valorDica)

func _on_ajuda2_pressed():
	if pular == true:
		bloqueada()
	else:
		ajuda = "pular"
		get_node("click").play()
		verificaDinheiro(game.valorPular)

func _on_ajuda3_pressed():
	if mais_tempo == true:
		bloqueada()
	else:
		ajuda = "tempo"
		get_node("click").play()
		verificaDinheiro(game.valorTempo)

func _on_ajuda4_pressed():
	if tesoura == true:
		bloqueada()
	else:
		ajuda = "tesoura"
		get_node("click").play()
		verificaDinheiro(game.valorTesoura)

#Função para imprimir uma mensagem para jogador informando que o mesmo não possui moedas suficientes
func alerta():
	desativaCena()
	get_node("Anim").play("ok")
	titulo.set_text("Alerta")
	texto.set_text("Infelizmente, você não possui moedas suficientes!")

#Função para bloquear uma ajuda e o jogador não possa adiquirí-la
func bloqueada():
	desativaCena()
	get_node("Anim").play("ok")
	titulo.set_text("Alerta")
	texto.set_text("Infelizmente, você não pode mais comprar esta ajuda!")

#Função que apresenta uma mensagem de confirmação informando uma breve descrição
#sobre cada uma das ajudas
func aparecerAjuda():
	desativaCena()
	get_node("Anim").play("aparecerAjuda")
	if ajuda == "dicas":
		titulo.set_text("Dicas")
		texto.set_text("Você deseja ver uma Dica da Pergunta?")
	elif ajuda == "pular":
		titulo.set_text("Pular")
		texto.set_text("Você deseja pular para a próxima pergunta?")
	elif ajuda == "tempo":
		titulo.set_text("+ Tempo")
		texto.set_text("Você deseja aumentar 15 segundos do seu total?")
	elif ajuda == "tesoura":
		titulo.set_text("Tesoura")
		texto.set_text("Você deseja eliminar um item?")

#Função para ativar a cena, ou seja, o timer volta novamente a contar e os botões podem ser clicados novamente
func ativaCena():
	if musica1 == true:
		musica1 = false
	elif musica2 == true:
		musica2 = false
	timerT.start()
	buttom1.set_process_input(true)
	buttom2.set_process_input(true)
	buttom3.set_process_input(true)
	buttom4.set_process_input(true)

#Função para desativar a cena, ou seja, o timer da pergunta para e o jogador não pode mais clicar nos botões da pergunta
func desativaCena():
	tempo = timerT.get_time_left()
	timerT.set_wait_time(tempo)
	timerT.stop()
	buttom1.set_process_input(false)
	buttom2.set_process_input(false)
	buttom3.set_process_input(false)
	buttom4.set_process_input(false)

#Função para desaparecer a ajuda
func desaparecerAjuda():
	ativaCena()
	get_node("Anim").play("desaparecerAjuda")

#Função que é executada quando o botão não da mensagem de confirmação da ajuda é pressionado
func _on_nao_pressed():
	get_node("click").play()
	desaparecerAjuda()

#Função que é executada quando o botão sim da mensagem de confirmação da ajuda é pressionado
func _on_sim_pressed():
	game.ajuda = true
	get_node("click").play()
	prossAjuda()

#Função responsável por executar a função de cada uma das ajudas
func prossAjuda():
	game.countDicas += precoAjuda #Soma o preço de cada uma das ajudas adquiridas
	#Instancia os nodes
	var item1 = get_node("Buttom1/Item1").get_text()
	var item2 = get_node("Buttom2/Item2").get_text()
	var item3 = get_node("Buttom3/Item3").get_text()
	var item4 = get_node("Buttom4/Item4").get_text()
	if ajuda == "dicas": #DICAS
		game.cDica += 1
		if game.score >= game.valorDica:
			game.score -= game.valorDica
		elif game.poupanca >= game.valorDica:
			game.poupanca -= game.valorDica
		get_node("Anim").play("dica")
		titulo.set_text("Dica")
		texto.set_text(str(game.arrayPergunta[game.nivelAtual-1][pergs][2]))
	elif ajuda == "pular": #PULAR PERGUNTA
		game.cPular += 1
		if game.score >= game.valorPular:
			game.score -= game.valorPular
		elif game.poupanca >= game.valorPular:
			game.poupanca -= game.valorPular
		game.nivelTerminou = false
		desaparecerAjuda()
		recarregar()
	elif ajuda == "tempo": #+TEMPO
		if game.score >= game.valorTempo:
			game.score -= game.valorTempo
		elif game.poupanca >= game.valorTempo:
			game.poupanca -= game.valorTempo
		tempo += 15
		timerT.set_wait_time(tempo)
		desaparecerAjuda()
	elif ajuda == "tesoura": #ELIMINA UM ITEM
		game.cTesoura += 1
		if game.score >= game.valorTesoura:
			game.score -= game.valorTesoura
		elif game.poupanca >= game.valorTesoura:
			game.poupanca -= game.valorTesoura
		desaparecerAjuda()
		var iCorreto = game.arrayPergunta[game.nivelAtual-1][pergs][1][0]
		if buttom1.get_pos() == Vector2(80, 576) and item1 != iCorreto:
			buttom1.set_pos(Vector2(-634.5,385))
		elif buttom2.get_pos() == Vector2(80, 713) and item2 != iCorreto:
			buttom2.set_pos(Vector2(760,570))
		elif buttom3.get_pos() == Vector2(80, 852) and item3 != iCorreto:
			buttom3.set_pos(Vector2(-634.5,753))
		elif buttom4.get_pos() == Vector2(80, 991) and item4 != iCorreto:
			buttom4.set_pos(Vector2(760,850))

#FUNÇÃO DO BOTÃO OK DA DICA
func _on_ok_pressed():
	get_node("Anim").play("dicaDesaparecer")
	get_node("click").play()
	ativaCena()

#ATRIBUIR SOM AOS BOTÕES DAS AJUDAS
func _on_Buttom1_pressed():
	get_node("click").play()

func _on_Buttom2_pressed():
	get_node("click").play()

func _on_Buttom3_pressed():
	get_node("click").play()

func _on_Buttom4_pressed():
	get_node("click").play()

#FUNÇÕES PARA SEREM EXECUTADAS CASO O JOGADOR TENHA MOEDAS SOMENTE NO BANCO
#Função do botão sim
func _on_sim1_pressed():
	get_node("click").play()
	get_node("Ajudas/mediacao/sim1").hide()
	get_node("Ajudas/mediacao/nao1").hide()
	prossAjuda()

#Função do botão não
func _on_nao1_pressed():
	get_node("click").play()
	ativaCena()
	desaparecerSimNao()

func aparecerSimNao():
	get_node("Ajudas/mediacao/sombra").show()
	get_node("Ajudas/mediacao/fundo").show()
	get_node("Ajudas/mediacao/titulo").show()
	get_node("Ajudas/mediacao/texto").show()
	get_node("Ajudas/mediacao/sim1").show()
	get_node("Ajudas/mediacao/nao1").show()

func desaparecerSimNao():
	get_node("Ajudas/mediacao/sombra").hide()
	get_node("Ajudas/mediacao/fundo").hide()
	get_node("Ajudas/mediacao/titulo").hide()
	get_node("Ajudas/mediacao/texto").hide()
	get_node("Ajudas/mediacao/sim1").hide()
	get_node("Ajudas/mediacao/nao1").hide()
