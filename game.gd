extends Node

#VARIAVEIS
var contador = 0 
var acertou = 0
var acertos = 0
var erros = 0
var nivel = 1
var nivelTerminou
var proximoCaminho
var nivelAtual = 0
var preco
var sexo = ""
var ajuda
var valorDica = 100
var valorPular = 100
var valorTempo = 50
var valorTesoura = 50
var countDicas = 0
var cDica = 0
var cPular = 0 
var cTesoura = 0
var countPular = 0
var cenaAtual
var ganhou = false
var nivelModif = false
var poupanca = 0 setget setPoupanca 
var score = 0 setget setScore 

#arrays (Prêmios e Perguntas)
var premios = [
	["celular", 400, false], 
	["video-game", 600, false], 
	["televisao", 1000, false], 
	["notebook", 1600, false], 
	["viagem", 2600, false]
]
var arrayPergunta = [		#[Enunciado][itens][Dica][Status para saber se a pergunta foi respondida]
							#Nível 1
						[
							["Perg1.1", ["i1","i2","i3","i4"], "Dica da Perg1.1", false], 
							["Perg1.2", ["i1","i2","i3","i4"], "Dica da Perg1.2", false], 
							["Perg1.3", ["i1","i2","i3","i4"], "Dica da Perg1.3", false], 
							["Perg1.4", ["i1","i2","i3","i4"], "Dica da Perg1.4", false] 
						],
							#Nível 2
						[
							["Perg2.1", ["i1","i2","i3","i4"], "Dica da Perg2.1", false], 
							["Perg2.2", ["i1","i2","i3","i4"], "Dica da Perg2.2", false],
							["Perg2.3", ["i1","i2","i3","i4"], "Dica da Perg2.3", false],
							["Perg2.4", ["i1","i2","i3","i4"], "Dica da Perg2.4", false],
							["Perg2.5", ["i1","i2","i3","i4"], "Dica da Perg2.5", false] 
						],
							#Nível 3
						[
							["Perg3.1", ["i1","i2","i3","i4"], "Dica da Perg3.1", false], 
							["Perg3.2", ["i1","i2","i3","i4"], "Dica da Perg3.2", false], 
							["Perg3.3", ["i1","i2","i3","i4"], "Dica da Perg3.3", false], 
							["Perg3.4", ["i1","i2","i3","i4"], "Dica da Perg3.4", false], 
							["Perg3.5", ["i1","i2","i3","i4"], "Dica da Perg3.5", false], 
							["Perg3.6", ["i1","i2","i3","i4"], "Dica da Perg3.6", false], 
							["Perg3.7", ["i1","i2","i3","i4"], "Dica da Perg3.7", false] 
						],
							#Nível 4
						[
							["Perg4.1", ["i1","i2","i3","i4"], "Dica da Perg4.1", false], 
							["Perg4.2", ["i1","i2","i3","i4"], "Dica da Perg4.2", false], 
							["Perg4.3", ["i1","i2","i3","i4"], "Dica da Perg4.3", false], 
							["Perg4.4", ["i1","i2","i3","i4"], "Dica da Perg4.4", false], 
							["Perg4.5", ["i1","i2","i3","i4"], "Dica da Perg4.5", false], 
							["Perg4.6", ["i1","i2","i3","i4"], "Dica da Perg4.6", false], 
							["Perg4.7", ["i1","i2","i3","i4"], "Dica da Perg4.7", false], 
							["Perg4.8", ["i1","i2","i3","i4"], "Dica da Perg4.8", false], 
							["Perg4.9", ["i1","i2","i3","i4"], "Dica da Perg4.9", false], 
							["Perg4.10", ["i1","i2","i3","i4"], "Dica da Perg4.10", false] 
						],
							#Nível 5
						[
							["Perg5.1", ["i1","i2","i3","i4"], "Dica da Perg5.1", false], 
							["Perg5.2", ["i1","i2","i3","i4"], "Dica da Perg5.2", false], 
							["Perg5.3", ["i1","i2","i3","i4"], "Dica da Perg5.3", false], 
							["Perg5.4", ["i1","i2","i3","i4"], "Dica da Perg5.4", false], 
							["Perg5.5", ["i1","i2","i3","i4"], "Dica da Perg5.5", false], 
							["Perg5.6", ["i1","i2","i3","i4"], "Dica da Perg5.6", false], 
							["Perg5.7", ["i1","i2","i3","i4"], "Dica da Perg5.7", false], 
							["Perg5.8", ["i1","i2","i3","i4"], "Dica da Perg5.8", false], 
							["Perg5.9", ["i1","i2","i3","i4"], "Dica da Perg5.9", false], 
							["Perg5.10", ["i1","i2","i3","i4"], "Dica da Perg5.10", false], 
							["Perg5.11", ["i1","i2","i3","i4"], "Dica da Perg5.11", false], 
							["Perg5.12", ["i1","i2","i3","i4"], "Dica da Perg5.12", false], 
							["Perg5.13", ["i1","i2","i3","i4"], "Dica da Perg5.13", false], 
							["Perg5.14", ["i1","i2","i3","i4"], "Dica da Perg5.14", false], 
							["Perg5.15", ["i1","i2","i3","i4"], "Dica da Perg5.15", false] 
						]
					]

#Variáveis para salvar o estado jogo
var save_file = File.new()
var save_path = "user://savegame.save"
var save_data = {"score": 0, "nivel": 1, "sexo": "", "acertos": 0, "erros": 0, "ganhou": false}

#SINAIS
signal score_mudou
signal poupanca_mudou

#FUNÇÕES
#Seta o valor dos pontos
func setScore(valor):
	score = valor
	emit_signal("score_mudou")

#Seta o valor dos pontos que estão no Banco
func setPoupanca(valor):
	poupanca = valor
	game.save()
	emit_signal("poupanca_mudou")

func _ready():
	#Verifica se o arquivo que irá armazenar os dados das variáveis existe
	#se não existir, o mesmo é criado e se existir o arquivo é lido
	if not save_file.file_exists(save_path):
		create_save()
	else:
		read()
	set_process(true)

#FUNÇÃO PARA CRIAR O ARQUIVO
func create_save():
	save_file.open(save_path, File.WRITE)
	save_file.store_var(save_data)
	save_file.store_var(premios)
	save_file.close()

#FUNÇÃO PARA VOLTAR PARA O ESTADO PADRÃO DO ARQUIVO
func delete():
	nivelAtual = 0
	save_data["score"] = 0
	save_data["nivel"] = 1
	save_data["sexo"] = ""
	save_data["acertos"] = 0
	save_data["erros"] = 0
	save_data["ganhou"] = false
	premios = [
	["celular", 400, false], 
	["video-game", 600, false], 
	["televisao", 1000, false], 
	["notebook", 1600, false], 
	["viagem", 2600, false]]
	save_file.open(save_path, File.WRITE)
	save_file.store_var(save_data)
	save_file.store_var(premios)
	save_file.close()
	read()

#FUNÇÃO PARA SALVAR O VALOR DAS VARIÁVEIS NO ARQUIVO
func save():
	save_data["score"] = poupanca
	save_data["nivel"] = nivel
	save_data["sexo"] = sexo
	save_data["acertos"] = acertos
	save_data["erros"] = erros
	save_data["ganhou"] = ganhou
	premios = premios
	save_file.open(save_path, File.WRITE)
	save_file.store_var(save_data)
	save_file.store_var(premios)
	save_file.close()

#FUNÇÃO PARA LER O ARQUIVO
func read():
	save_file.open(save_path, File.READ)
	save_data = save_file.get_var()
	premios = save_file.get_var()
	save_file.close()
	poupanca = save_data["score"]
	nivel = save_data["nivel"]
	sexo = save_data["sexo"]
	acertos = save_data["acertos"]
	erros = save_data["erros"]
	ganhou = save_data["ganhou"]
	premios = premios

#VERIFICA CONTINUAMENTE SE O JOGADOR ATINGIU A QUANTIDADE DE PERGUNTAS DO NÍVEL
func _process(delta):
	if getNumPerguntasNivel() == contador:
		nivelTerminou = true
		contador = 0

#FUNÇÃO PARA MUDAR DE CENA
func mudar_scene(path):
	proximoCaminho = path
	if proximoCaminho != null:
		get_tree().change_scene(proximoCaminho)

#FUNÇÃO PARA RETORNAR A QUANTIDADE DE PERGUNTAS PARA CADA NÍVEL
func getNumPerguntasNivel():
	if nivelAtual == 1:
		return 2
	elif nivelAtual == 2:
		return 3
	elif nivelAtual == 3:
		return 5
	elif nivelAtual == 4:
		return 8
	elif nivelAtual == 5:
		return 13