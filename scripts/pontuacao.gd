extends Label

func _ready():
	set_text(str(game.score)) #Seta o valor dos pontos no nível
	game.connect("score_mudou", self, "_on_score_mudou") #Quando a quantidade de moedas no nível mudar é executada a função _on_score_mudou

func _on_score_mudou():
	set_text(str(game.score))