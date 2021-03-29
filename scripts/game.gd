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
var cena
var pontuacaoTotal = 0
var loja = true
var ganhou = false
var nivelModif = false
var comprou = false
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
							["Visitando a fazendo do vovô, você percebeu que o leite das vaquinhas da fazenda é vendido. Isso é uma forma de obter:", ["Lucro","Dívidas","Empréstimos","Diversão"], "Vender algo que todos precisam é uma ótima forma de ganhar dinheiro.", false], 
							["Além da venda dos ovos, como seus pais poderiam ganhar mais dinheiro com as galinhas?", ["Vender as galinhas que não põem ovos","Não tem como ganhar mais dinheiro","Emprestando as galinhas","Comendo as galinhas"], "Todo mundo gosta de comer carne de galinha.", false], 
							["Sua mãe tem uma ótima plantação de verduras para usar na comida de casa. As verduras começam a sobrar e ela decidiu vendê-las para ter uma renda extra no final do mês. Como você pode ajudá-la?", ["Oferecendo aos vizinhos que não plantam verduras","Comendo as verduras","Emprestando às verduras","Deixando que sua mãe cuide disso sozinha"], "As pessoas compram coisas que não conseguem produzir.", false],
							["A porca 'Fifi' da fazenda da sua família acabou de dar filhotes. O que seus pais podem fazer com os filhotes depois que eles pararem de mamar?", ["Vender os filhotes","Abandonar os filhotes","Ficar com todos","Dar eles de presente"], "Vender o que não precisa ou o que não pode cuidar sempre é uma forma de ganhar dinheiro.", false] 
						],
							#Nível 2
						[
							["Comprar perus no início do ano para vender no período do natal é um ótimo exemplo de?", ["Investimento","iDesperdício","Prejuízo","Ganhar dinheiro"], "Vender algo quando a procura é maior é uma ótima oportunidade de ganhar dinheiro.", false], 
							["Não houve inverno, os açudes estão secos e o pasto morreu. Tudo está caro. Seu pai resolve comprar alguns bois par engordar e ganhar dinheiro. Nessa situação, esse negócio é?", ["Arriscado","Sem riscos","Lucrativo","Estável"], "Todo investimento tem risco, mas se a situação está muito arriscada é melhor deixar esse investimento para outra oportunidade.", false], 
							["Comprar cabrinhas novas, criar e vender quando elas estiverem grandes é um exemplo de?", ["Investimento a médio prazo","Prejuízo a longo prazo","Investimento a longo prazo","Investimento a curto prazo"], "Cabrinhas sempre são um bom investimento. Em cerca de um ano elas já podem ser vendidas ou já estão dando novos filhotes.", false],
							["Seus pais pedem que vá ao sítio do seu José para comprar ovos de galinha caipira e dizem:  'o que sobrar é seu'. O que você faz com o dinheiro?", ["Guarda e economiza.","Gasta com bombons","Compra comida","Compra doce na padaria"], "Não gaste dinheiro sem necessidade. Quem poupa sempre tem.", false], 
							["Seus pais precisam construir um curral para os animais com urgência, mas não possuem dinheiro suficiente. Se eles não fizerem, podem ter um grande prejuízo. Qual a melhor alternativa?", ["Fazer um empréstimo para pagar a longo prazo","Vender os animais","Não fazer o curral","Fazer um empréstimo para pagar com um mês"], "Dívidas para pagar a longo prazos podem ser uma alternativa para situações emergenciais.", false], 
						],
							#Nível 3
						[
							["Todo domingo você vai com seu avô para a feira da cidade para ajudar a vender os queijos da fazenda. Ao retomar seu avô lhe dá uns trocados pela ajuda. O que você deve fazer com esse dinheiro recebido?", ["Guarda em um cofrinho","Gasta com pizza","Vai jogar na lan-house","Gasta no parquinho"], "Poupar e não gastar com besteira é sempre uma opção para se conseguir comprar coisas importantes.", false],
							["No sitio da sua família tem uma  grande produção de frutas, laranja, maracujá entre outras frutas cítricas. Sua mãe não gosta de desperdiçar frutas. O que você faria para evitar o desperdício e ainda conseguir uma renda extra?", ["Vender as frutas e o suco delas","Comer tudo antes que estrague","Dar aos vizinhos","Deixar apodrecer"], "Tudo que se produzir com a ideia certa pode virar uma bom negócio.", false],
							["Seu pai tem no sitio várias vacas leiteiras, além do leite que outros produtos poderiam ser produzidos e vendidos a partir do leite das vaquinhas?", ["Queijo, Nata.","Mingau","Chocolate","Sanduíches"], "Algumas matérias primas naturais como o leite podem render outros produtos que podem ser uma boa fonte de renda extra.", false], 
							["Os seus vizinhos não criam galinhas, por isso sempre estão a procura de ovos. Você sabe que sua mãe cria muitas galinhas, o que você sugere:", ["A venda de ovos","Divisão das galinhas","Divisão dos ovos","Comer todos os ovos e não dividir"], "Tudo que é de difícil ter em um certo local, pode ser um bom negócio.", false],
							["Sua mãe tem uma boa plantação de cenouras e batatas, você sabe que na feirinha da cidade a saca de batata custa caro e a cenoura também. O que você faria com a batata e a cenoura se fosse sua mãe?", ["Venderia na feira da cidade","Não plantaria mais batata e nem cenoura","Plantaria menos","Aumentava a produção"], "Tudo que se produzir  pode virar renda.", false],
							["Seu pai fez uma boa safra de milho e feijão, depois de tirar o suficiente para o consumo da família o que o seu pai poderia fazer com o resto?", ["Vender as sacas de feijão e de milho.","Jogar fora","Guarda para o ano que vem","Distribuir entre os vizinhos"], "Venda de produtos base pode ser um ótimo negócio.", false],
							["Seu pai todo o mês faz as contas do quanto será gasto na fazenda com os animais e com as plantas. Quando ele faz essas contas ele está fazendo o que?", ["Controlando as contas","Perdendo tempo","Ganhando dinheiro","Gastando tempo e dinheiro"], "Anotar e saber de todos os gastos do mês é uma ótima prática para controlar o orçamento e dinheiro da família.", false]
						],
							#Nível 4
						[
							["A ração dos porcos só dá para mais cinco dias, mas o seu pai somente terá dinheiro daqui a quinze dias e resolve economizar na comida até o dia que tiver dinheiro. Isso foi uma forma de:", ["Controlar gastos","Gastar mais","Investir","Desperdiçar"], "Controlar as coisas permite passar por situações que necessitam uma maior economia.", false],
							["Todo o mês sua mãe compra adubo para a horta. Ela explicou que ele deve ser colocado na quantidade correta. Se você não colocar na quantidade correta, o que pode acontecer?", ["Gastos imprevistos","Renda Extra","Lucro no mês","As plantas morrerem"], "A falta de controle e a não economia pode gerar problemas que não eram previstos.", false],
							["Outro dia o motor que puxa a água do poço queimou, gerando um gasto imprevisto. Seu pai resolveu a situação facilmente retirando dinheiro da poupança para o conserto do motor, isso mostra que seu pai possui:", ["Possui uma reserva para emergências","Falta de dinheiro","Problema que não podem ser resolvidos","Despreparo para emergências"], "Quem poupa pouco ou muito sempre tem.", false],
							["Hoje pela manhã, um dos canos de água da sua casa furou. Para não desperdiçar a água, seu pai juntou alguns pedaços de cano e desviou a água que estava vazando para a horta de verduras da sua mãe, evitando desperdício. O que seu pai fez?", ["Desperdício","Dívidas","Gastos imprevistos","Não se importa com prejuízos"], "Situações inesperadas podem acontecer. Temos sempre que tentar diminuir desperdícios e minimizar os prejuízos.", false],
							["Sua mãe decide visitar sua tia na capital. Ela vem guardando dinheiro para essa viagem a seis meses. Na véspera da viagem, ela percebe uma doença nos peitinhos e tem que comprar remédio. Ela só recebe dinheiro próxima semana. Então ela decide adiar a viagem e comprar o remédio e evitar que eles morram. O que ela fez?", ["Evitou um prejuízo","Gosta da mais dos pintinhos do que da irmã","Deixou de se divertir","Se apressou em comprar os remédios"], "Deve-se agir com inteligência e priorizar as coisas para que não se tenha prejuízo.", false],
							["Seu avô sempre diz que sua avó desperdiça muito milho com as galinhas e no fim do mês ele não consegue pagar o armazém da ração. Isso mostra?", ["Que sua Avó está desperdiçando muito milho","Seu avô reclama demais","Sua avó está fazendo a coisa certa","As galinhas comem muito mesmo"], "Quem não sabe cuidar do seu dinheiro termina por não ter condições de pagar todas as dívidas.", false],
							["Seu pai vende ovos de galinha e sempre que ele pode lhe dar algumas moedinhas. Ele disse que se você guardar essas moedinhas, logo terá muito dinheiro para comprar algo no futuro. O seu pai está ensinando?", ["Poupar","Gastar","Vender","Emprestar"], "Guarde agora para ter no futuro.", false],
							["Sempre que você sai do quarto, sua mãe pede para que apague a luz. Isso é uma forma de?", ["Economizar energia","Desperdiçar energia","Gastar energia","Ser descuidado"], "Energia é muito caro! Através de alguns cuidados, podemos reduzir a conta de luz.", false],
							["Seu pai pede para você regar a horta durante 5 minutos e que não passe desse tempo. O gasto de água precisa ser controlado, pois a conta no fim do mês é cara. O que acontece se você ultrapassar o tempo que seu pai indicou?", ["Desperdiçando água e dinheiro","Cuidando bem da planta, pois ela precisa de bastante água","Desperdiçando só água","Desperdiçando só dinheiro"], "A água é o elemento essencial para a nossa sobrevivência e para todos os seres que dela precisam, por isso devemos ser conscientes em relação ao seu gasto.", false],
							["Sua irmã disse que hoje as galinhas colocam mais ovos do que necessário para o consumo da família. Ela disse que você poderia no caminho da escola vender os ovos que sobraram e ficar com o dinheiro. Você resolveu guardar o dinheiro para comprar algo no futuro. O que você fez?", ["Poupou","Gastou","Desperdiçou","Emprestou"], "Aquele que economiza hoje, muito mais terá para gastar amanhã.", false],
						],
							#Nível 5
						[
							["Sua mãe tem uma horta cheia de verduras, mas ela não tem tempo para vender. Então, ela resolveu chamar uma amiga que estava sem emprego para vender essas verduras e dividir o lucro. Isso é um exemplo de?", ["Parceira de negócio","Dar dinheiro para os outros","Amizade","Perder dinheiro"], "Muitas vezes trabalhar em parceria pode render ótimos lucros.", false],
							["Seus pais recebem o dinheiro das vendas de ovos, leite, verduras e legumes. Depois de pagar todas as contas do mês eles depositam o que sobra no banco pensando no futuro. Essa conta no banco é uma?", ["Poupança","Promissória","Hipoteca","Dívida"], "Existem vários tipos de contas em um banco, portanto, na hora de abrir uma conta escolha deve ser aquela que mais lhe ajuda a poupar.", false],
							["Sua mãe planta pimenta e ela está pensando em como ganhar algum dinheiro através das pimentas. O que ela poderia fazer?", ["Fazer o molho e vender","Pimenta não dá dinheiro","Poderá vender baratinho as pimentas","Apenas usar para consumo"], "Fazer um produto de um alimento aumenta a margem de lucro.", false],
							["Você foi com seu pai à feira e ele estava apenas com o dinheiro das compras e você queria muito um brinquedo, mas seu pai disse que não poderia comprar, o que você deve fazer?", ["Entender e esperar","Chorar","Ficar triste","Espernear"], "Às vezes nossos desejos são apenas desejos, mas, para aqueles que poupam eles podem ser concretos.", false],
							["Seu pai foi até o sítio do seu tio e comprou um porco por R$ 100,00, depois de alguns meses, ele vendeu esse porco R$ 300,00. Assim o seu pai:", ["Ganhou R$ 200,00","Não ganhou e nem perdeu","Perdeu R$ 200,00","Teve prejuízo"], "Vender uma coisa mais caro do que você comprou é uma forma de ganhar dinheiro e lucrar.", false],
							["Seu pai comprou uma vaca por R$ 2000,00. Em 6 meses ele gastou R$ 400,00 com alimentação dela. Um vizinho gostou da vaca e quis comprá-la. Por quanto ele deveria vendê-la para não tendo prejuízo?", ["Acima de R$ 2400,00","Por R$ 2000,00","Acima de R$ 2000,00","Por R$ 2400,00"], "Para vender algo sem prejuízo, deve-se contabilizar o preço de compra, o que se gostou e o tempo que se gastou.", false],
							["Seu pai comprou um carneiro que era do seu tio por R$ 80,00. Três meses depois ele vendeu ao seu vizinho por R$ 120,00. Só que ele já tinha gastado R$ 50,00 com milho e remédios para o carneiro. Nessa situação, seu pai teve?", ["Prejuízo","Lucro","Pagou o investimento","Ganho"], "Quando o investimento não rende o esperado ele gera desfalque no esperado.", false],
							["As vaquinhas podem render um bom dinheiro. Delas é possível tirar leite, fazer queijo, nata e outros produtos. Seu pai decide montar uma vacaria e só tem R$ 10.000,00. Esse dinheiro é chamado de?", ["Capital Inicial","Lucro","Ganho","Empréstimo"], "Para começar qualquer novo negócio é preciso de um valor inicial que irá compor o capital da empresa.", false],
							["Todo mês seu pai vai na pocilga do seu Zé e compra um bacurim por R$ 100,00 e vende na cidade por R$ 150,00. Se ele comprar 5 porcos em um mês, quanto ele ganhará?", ["R$250,00","R$200,00","R$100,00","R$500,00"], "O'Lucro é a diferença entre o que foi gasto e o valor que será vendido.", false],
							["O bacurim Chicó que seu pai comprou por R$ 100,00, após 3 meses,  comeu R$ 80,00 de ração e gastou mais R$ 20,00 com remédios. Se seu pai  vender o Chicó por R$ 200,00, ele:", ["Recupera o que gastou","Têm prejuízo.","Cria uma dívida.","Ganhou muito dinheiro em cima do que gastou."], "Lucrar é sempre bom, mas nem sempre é possível. As vezes é melhor empatar o dinheiro gasto como dinheiro ganho do que ter prejuízo.", false],
							["Criar peixe no inverno está dando muito dinheiro. Para iniciar a criação no açude, seu pai precisa de R$ 1500,00. Ele só pode vender 3 vaquinhas por R$ 1200,00. Qual seria a melhor opção para ele?", ["Negociar para pagar o restante do dinheiro a prazo","Desistir do negócio","Pedir dinheiro emprestado com juros altíssimos","Esperar para iniciar o negócio só quando tiver o dinheiro"], "Prorrogar dívidas sempre é um bom negocio", false],
							["A praga de lagarta atacou a plantação de feijão e milho do seu pai, ele precisa comprar veneno para acabar com a praga. é melhor comprar 2 litros de veneno por R$ 150,00 ou 1 litro por R$ 100,00?", ["Compra os 2 litros de veneno","Comprar o 1 litro de veneno","Compra 1 litro de veneno e depois comprar mais 1 litro depois","O veneno está caro e é melhor deixar sem expurgar."], "Comprar em maior quantidade de vez sai sempre mais barato", false],
							["Alguém quer comprar a saca de feijão do seu pai por R$ 100,00. Na feira da cidade o feijão custa R$ 200,00. Seu pai gastaria R$ 50,00 para levar uma saca de feijão para a cidade. Qual a melhor opção para seu pai ganhar mais dinheiro?", ["Vender na feira da cidade","Vender ao homem porque ele paga mais","Vender ao homem porque não teria gasto com transporte","Vender na feira ou ao homem é a mesma coisa"], "Vender diretamente na cidade e ter mais um pouco de trabalho é mais vantajoso do que vender na fazenda", false],
							["Sua mãe precisa de R$ 50,00 reais para comprar as sementes para fazer uma horta. Uma amiga tirou do banco e emprestou esse valor para ela pagar o dobro em 3 meses. Sua mãe com um mês já tinha vendido R$ 100,00 de verduras. O negócio para sua mãe foi?", ["Muito bom porque antes do prazo já conseguiu o dinheiro para pagar o empréstimo","Ruim pois não pagou o dinheiro emprestado","Bom. Só deu para o empréstimo","Ruim. Porque o juros do dinheiro emprestado foi muito alto"], "Se tomar dinheiro emprestado a juros alto compensa é a única opção, mas você sabe que irá lucrar o suficiente para pagar, pode ser uma boa opção.", false],
							["Seu pai conseguiu uma boa safra de milho. Ele gastou R$ 30,00 e irá vender cada saca por R$ 70,00. Quanto o seu pai irá lucrar com 100 sacas?", ["R$4.000,00","R$70,00","R$400,00","R$7.000,00"], "O lucro é a diferença entre o que foi gasto e o valor que será vendido", false],
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