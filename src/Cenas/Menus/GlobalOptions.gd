extends Node

# Guarda a referência dos itens que devem ser escondidos durante o diálogo
var itemsToHideDialog = []

# Seta a lista de itens para esconder durante o diálogo
func setItemsToHideOnDialog(items: Array):
	itemsToHideDialog = []
	for i in range(0, len(items)):
		if items[i] && is_instance_valid(items[i]):
			itemsToHideDialog.append({
				'item': items[i],
				'alreadyVisible': items[i].visible
			})
	
# Esconde os itens de HUD da variável global
func hideHUDItems():
	for i in range (0, len(itemsToHideDialog)):
		if itemsToHideDialog[i] && is_instance_valid(itemsToHideDialog[i]['item']):
			itemsToHideDialog[i]['alreadyVisible'] = itemsToHideDialog[i]['item'].visible
			itemsToHideDialog[i]['item'].hide()
			

# Mostra os itens de HUD da variável global
func showHudItems():
	for i in range (0, len(itemsToHideDialog)):
		if itemsToHideDialog[i] && is_instance_valid(itemsToHideDialog[i]['item']) && itemsToHideDialog[i]['alreadyVisible']:
			itemsToHideDialog[i]['item'].show()

# Lingua
var isPortuguese = true

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
