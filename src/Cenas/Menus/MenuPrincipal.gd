extends Control

# Função executada quando o botão de novo jogo é pressionado 
func _on_BotaoNovoJogo_pressed():
	return get_tree().change_scene("res://Cenas/Utilitarios/Carregando.tscn")

# Função executada quando o botão de opções é pressionado
func _on_BotaoOpcoes_pressed():
	return get_tree().change_scene("res://Cenas/Menus/MenuOpcoes.tscn")

# Função executada quando o botão Sair é pressionado
func _on_BotaoSair_pressed():
	return get_tree().quit()

# Troca os textos de acordo com a linguagem
func _ready():
	if GlobalOptions.isPortuguese:
		$BotaoNovoJogo.text = '__Novo Jogo__'
		$BotaoOpcoes.text = '__Opções__'
		$BotaoSair.text = '__Sair__'
	else:
		$BotaoNovoJogo.text = '__New Game__'
		$BotaoOpcoes.text = '__Options__'
		$BotaoSair.text = '__Quit__'
