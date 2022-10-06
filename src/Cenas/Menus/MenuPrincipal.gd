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
	
# Função executada quando o botão prólogo é pressionado. Abre um vídeo no youtube com o prólogo
func _on_BotaoPrologo_pressed():
	if GlobalOptions.isPortuguese:
		OS.shell_open("https://youtu.be/RwOVy2hh93U")
	else:
		OS.shell_open("https://youtu.be/JMVG3NpSRYo")


# Troca os textos de acordo com a linguagem
func _ready():
	$AudioStreamPlayer2D.play()
	if GlobalOptions.isPortuguese:
		$VBoxContainer/BotaoNovoJogo/Label.text = 'Novo Jogo'
		$VBoxContainer/BotaoOpcoes/Label.text = 'Opções'
		$VBoxContainer/BotaoSair/Label.text = 'Sair'
		$VBoxContainer/BotaoPrologo/Label.text = 'Prólogo'		
	else:
		$VBoxContainer/BotaoNovoJogo/Label.text = 'New Game'
		$VBoxContainer/BotaoOpcoes/Label.text = 'Options'
		$VBoxContainer/BotaoSair/Label.text = 'Quit'
		$VBoxContainer/BotaoPrologo/Label.text = 'Prologue'				
		
func _process(delta):
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-5)
		

