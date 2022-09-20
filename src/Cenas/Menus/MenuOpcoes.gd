extends Control

onready var language = $TextureRect/ContainerOpcoes/OptionButton
# Função para criar as opções de dificuldade
func SetLanguage():
	
	# Seta as opções do dropdown
	language.add_item("Português") #0
	language.add_item("English") #1
	
	# Seta a opção selecionada como médio
	language.select(0)

	# Cria o evento de mudança de opção selecionada
	language.connect("item_selected", self, "on_item_selected")
	

# Função executada quando a opção do dropdown de dificuldade muda
func on_item_selected(id):
	print(id)

# Função executada quando clica no botão voltar
func _on_BotaoVoltarMenuPrincipal_pressed():
	get_tree().change_scene("res://Cenas/Menus/MenuPrincipal.tscn")	

# Quando o documento estiver pronto
func _ready():
	SetLanguage()
	$TextureRect/ContainerOpcoes/RangeMaster.value = GlobalOptions.masterVolume
	$TextureRect/ContainerOpcoes/RangeMusic.value = GlobalOptions.musicVolume
	$TextureRect/ContainerOpcoes/RangeSFX.value = GlobalOptions.sfxVolume

func _process(delta):
	if language.selected == 0:
		GlobalOptions.isPortuguese = true
	elif language.selected == 1:
		GlobalOptions.isPortuguese = false
	
	GlobalOptions.masterVolume = $TextureRect/ContainerOpcoes/RangeMaster.value
	GlobalOptions.musicVolume = $TextureRect/ContainerOpcoes/RangeMusic.value
	GlobalOptions.sfxVolume = $TextureRect/ContainerOpcoes/RangeSFX.value
