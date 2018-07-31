extends Node

func _ready():
#	set_text(str(game.acertos)+"\n"+str(game.erros))
	var arrayPergunta = [
							#Nível 1
						[
							["Perg1.1", ["i1","i2","i3","i4"], "Dica da Perg1.1", false], 
							["Perg1.2", ["i1","i2","i3","i4"], "Dica da Perg1.2", false] 
						],
							#Nível 2
						[
							["Perg2.1", ["i1","i2","i3","i4"], "Dica da Perg2.1", false], 
							["Perg2.2", ["i1","i2","i3","i4"], "Dica da Perg2.2", false] 
						],
							#Nível 3
						[
							["Perg3.1", ["i1","i2","i3","i4"], "Dica da Perg3.1", false], 
							["Perg3.2", ["i1","i2","i3","i4"], "Dica da Perg3.2", false] 
						],
							#Nível 4
						[
							["Perg4.1", ["i1","i2","i3","i4"], "Dica da Perg4.1", false], 
							["Perg4.2", ["i1","i2","i3","i4"], "Dica da Perg4.2", false] 
						],
							#Nível 5
						[
							["Perg5.1", ["i1","i2","i3","i4"], "Dica da Perg5.1", false], 
							["Perg5.2", ["i1","i2","i3","i4"], "Dica da Perg5.2", false] 
						]
					]
	print(arrayPergunta[0][0][3])
	pass
