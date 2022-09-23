extends Control

onready var language = $TextureRect/ContainerOpcoes/OptionButton
# Função para criar as opções de dificuldade
func SetLanguage():
	
	# Seta as opções do dropdown
	language.add_item("Português") #0
	language.add_item("English") #1
	
	# Seta a opção selecionada como médio
	if GlobalOptions.isPortuguese:
		language.select(0)
	else:
		language.select(1)

	# Cria o evento de mudança de opção selecionada
	language.connect("item_selected", self, "on_item_selected")
	


# Função executada quando clica no botão voltar
func _on_BotaoVoltarMenuPrincipal_pressed():
	get_tree().change_scene("res://Cenas/Menus/MenuPrincipal.tscn")	

# Quando o documento estiver pronto
func _ready():
	SetLanguage()
	if GlobalOptions.isPortuguese:
		$TextureRect/Title.text = "Configurações"
		$TextureRect/ContainerOpcoes/MasterVolume.text = 'Volume Geral'
		$TextureRect/ContainerOpcoes/Music.text = 'Volume da Música'
		$TextureRect/ContainerOpcoes/SFX.text = 'Volume dos Efeitos Sonoros'
		$TextureRect/ContainerOpcoes/Language.text = 'Língua'
		$TextureRect/BotaoVoltarMenuPrincipal/Label.text = 'Salvar e Sair'
	else:
		$TextureRect/Title.text = "Configurations"
		$TextureRect/ContainerOpcoes/MasterVolume.text = 'General Volume'
		$TextureRect/ContainerOpcoes/Music.text = 'Music Volume'
		$TextureRect/ContainerOpcoes/SFX.text = 'Sound Effects Volume'
		$TextureRect/ContainerOpcoes/Language.text = 'Language'
		$TextureRect/BotaoVoltarMenuPrincipal/Label.text = 'Save Changes'
	$TextureRect/ContainerOpcoes/RangeMaster.value = GlobalOptions.masterVolume
	$TextureRect/ContainerOpcoes/RangeMusic.value = GlobalOptions.musicVolume
	$TextureRect/ContainerOpcoes/RangeSFX.value = GlobalOptions.sfxVolume

# Verifica e troca a linguagem, define os sons
func _process(delta):
	if language.selected == 0:
		GlobalOptions.isPortuguese = true
	elif language.selected == 1:
		GlobalOptions.isPortuguese = false
	
	GlobalOptions.masterVolume = $TextureRect/ContainerOpcoes/RangeMaster.value
	GlobalOptions.musicVolume = $TextureRect/ContainerOpcoes/RangeMusic.value
	GlobalOptions.sfxVolume = $TextureRect/ContainerOpcoes/RangeSFX.value
