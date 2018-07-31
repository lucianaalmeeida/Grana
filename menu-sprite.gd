extends Sprite

func _ready():
	if game.sexo == "F":
		set_texture(load("res://sprites/icone-menu-F.png"))
	elif game.sexo == "M":
		set_texture(load("res://sprites/icone-menu-M.png"))