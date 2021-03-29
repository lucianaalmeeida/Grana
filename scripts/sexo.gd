extends Sprite

func _ready():
	#Verifica qual o sexo do personagem escolhido para carregar o avatar correto na cena dos níveis
	if game.sexo == "F":
		set_texture(load("res://sprites/menina.png"))
	elif game.sexo == "M":
		set_texture(load("res://sprites/menino.png"))
