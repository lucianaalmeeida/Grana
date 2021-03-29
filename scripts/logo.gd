extends CanvasLayer

#APRESENTAR A ANIMAÇÃO DA LOGO
func _ready():
	get_node("Anim").play("Fade")

#FUNÇÃO PARA MUDAR PARA A CENA DO MENU
func mudar_scene():
	get_tree().change_scene("res://scenes/menu.tscn")