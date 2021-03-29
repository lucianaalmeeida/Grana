extends Node
#VARIÁVEIS
var count = 0
onready var click = get_node("click-buttom")
onready var timer = get_node("Timer")

#FUNÇÃO PARA SER EXECUTADA QUANDO O BOTÃO MENINA FOR PRESSIONADO
func _on_menina_pressed():
	click.play()
	timer.start()
	timer.connect("timeout", self, "on_timeout_menina")

func on_timeout_menina():
	salvarSexo("F")

#FUNÇÃO PARA SER EXECUTADA QUANDO O BOTÃO MENINO FOR PRESSIONADO
func _on_menino_pressed():
	click.play()
	timer.start()
	timer.connect("timeout", self, "on_timeout_menino")

func on_timeout_menino():
	salvarSexo("M")

#FUNÇÃO PARA SALVAR O PERSONAGEM ESCOLHIDO PELO JOGADOR E MUDAR DE CENA
func salvarSexo(sexo):
	game.sexo = sexo 
	game.save() #SALVA
	game.read() #LER
	transition.fade_to("res://scenes/niveis.tscn")

#FUNÇÃO PARA VERIFICAR QUAL MENSAGEM SERÁ SERÁ APRESENTADA PARA O JOGADOR 
func _on_mensagem_pressed():
	click.play()
	if count == 0:
		setMensagem("Aqui você aprenderá a utilizar seu dinheiro da melhor forma possível!")
	elif count == 1:
		setMensagem("Em cada nível você responderá perguntas relacionadas ao uso adequado do dinheiro.")
	elif count == 2:
		setMensagem("Para passar de nível é necessário responder uma certa quantidade perguntas corretamente.")
	elif count == 3:
		setMensagem("Você poderá comprar ajudas, estas irão lhe ajudar à responder as perguntas. Mas tome cuidado para não acabar o seu dinheiro comprando apenas isso.")
	elif count == 4:
		setMensagem("Após, finalizar cada nível você poderá guardar suas moedas no Banco ou comprar alguma coisa na loja com elas. ")
	elif count == 5:
		setMensagem("Para começar, escolha o seu personagem.")
	elif count == 6:
		escolherSexo()

#FUNÇÃO PARA SETAR QUALQUER MENSAGEM E INCREMENTAR A VARIÁVEL COUNT
func setMensagem(msg):
	get_node("msg").set_text(msg)
	count += 1

func _on_pular_pressed():
	escolherSexo()

func escolherSexo():
	get_node("mensagem").hide()
	get_node("pular").hide()
	get_node("msg").hide()
	get_node("img").show()
	get_node("menino 2").show()
	get_node("menina 2").show()
	get_node("menino").show()
	get_node("menina").show()