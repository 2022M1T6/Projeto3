extends Node

# Guarda a referência dos itens que devem ser escondidos durante o diálogo
var itemsToHideDialog = []

# Seta a lista de itens para esconder durante o diálogo
func setItemsToHideOnDialog(items: Array):
	itemsToHideDialog = items
	
# Esconde os itens de HUD da variável global
func hideHUDItems():
	for i in range (0, len(GlobalOptions.itemsToHideDialog)):
		if GlobalOptions.itemsToHideDialog[i] && is_instance_valid(GlobalOptions.itemsToHideDialog[i]):
			GlobalOptions.itemsToHideDialog[i].hide()

# Mostra os itens de HUD da variável global
func showHudItems():
	for i in range (0, len(GlobalOptions.itemsToHideDialog)):
		if GlobalOptions.itemsToHideDialog[i] && is_instance_valid(GlobalOptions.itemsToHideDialog[i]):
			GlobalOptions.itemsToHideDialog[i].show()

# Lingua
var isPortuguese = false

# Volume
var masterVolume = 100
var musicVolume = 100
var sfxVolume = 100
var dimensoes = {"vision": false, "roadmap": false}
var isPaused = false

func setSFXSound(a : float):
	var volume = masterVolume * sfxVolume / 100
	var dB = ((4*volume/10) + a - 40)
	return dB

func setMusicSound(a):
	var volume = masterVolume * musicVolume / 100
	var dB = ((4*volume/10) + a - 40)
	return dB
