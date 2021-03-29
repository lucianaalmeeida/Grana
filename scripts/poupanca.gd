extends Label

func _ready():
	set_text(str(game.poupanca)) #SETA O VALOR DA POUPANÇA NO LABEL
	game.connect("poupanca_mudou", self, "_on_poupanca_mudou") #QUANDO O SINAL poupanca_mudou FOR ACIONADO A FUNÇÃO _on_poupanca_mudou É EXECUTADA

func _on_poupanca_mudou():
	set_text(str(game.poupanca)) #SETA O VALOR DA POUPANÇA