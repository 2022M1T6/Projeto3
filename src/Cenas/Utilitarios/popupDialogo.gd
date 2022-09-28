extends PopupDialog

onready var dialogBoxLabel = $DialogBox/Label
export (bool) var startedDialog = false
var canGoToNextLine = false
var canCompleteLine = false
var diag

var dialogs = []
var currentDialog = {"personagem": "", "falas": []}


func _process(delta):
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setSFXSound(15)
	 
	
# Função que estabelece qual sprite usar quando estiver na fala
func getDialogSpriteFilePath():
	if currentDialog["personagem"] == 'dellson':
		return "res://Public/Characters/dellsonProfile.png"
	elif currentDialog["personagem"] == 'jose':
		return "res://Public/Characters/playerProfile.png"
	elif currentDialog["personagem"] == 'blacksmith':
		return "res://Public/Characters/blacksmithProfile.png"
	elif currentDialog["personagem"] == 'king':
		return "res://Public/Characters/kingProfile.png"
	elif currentDialog["personagem"] == 'lumberjack':
		return "res://Public/Characters/lumberjackProfile.png"
	elif currentDialog["personagem"] == 'marketer':
		return "res://Public/Characters/marketerProfile.png"
	elif currentDialog["personagem"] == 'swordsman':
		return "res://Public/Characters/swordsmanProfile.png"
	elif currentDialog["personagem"] == 'gallo':
		return "res://Public/Characters/galloProfile.png"
	else:
		return "res://Public/Characters/fabiProfile.png"


		
# Função que envia um diálogo
func sendDialog(dialog):
	if startedDialog:
		return
	
	addDialog(dialog)
	startedDialog = true
	showNextMessageOnList()
	GlobalOptions.hideHUDItems()
	get_tree().paused = true
	
# Função que adiciona um array de diálogo para a lista
func addDialog(dialog):
	match typeof(dialog):
		18:
			dialogs.append(dialog)
		19:
			dialogs.append_array(dialog)

# Função que mata o diálogo da tela
func killDialog():
	startedDialog = false
	hide()
	get_tree().paused = false
	GlobalOptions.showHudItems()

# Função que pega a próxima linha de diálogo
func getNextSpeak():
	if currentDialog["falas"].size() == 0 && dialogs.size() == 0:
		return
	
	if(currentDialog["falas"].size() == 0):
		currentDialog = dialogs.pop_front()
		return getNextSpeak()
	else:
		return currentDialog["falas"].pop_front()

# Função que insere o texto na label e deixa-o invisível
func setText(text):
	dialogBoxLabel.percent_visible = 0
	dialogBoxLabel.text = text
	canGoToNextLine = false


# Função que mostra a próxima mensagem do array de diálogos
func showNextMessageOnList() -> void:
	var text = getNextSpeak()
	
	if !text:
		killDialog()
		return
		
	setText(text)

	# Verifica se a foto da caixa de diálogo está condizente com o personagem e troca caso necessário
	$DialogSprite.texture = load(getDialogSpriteFilePath())

	show()
	return

# Função que completa a linha automaticamente
func completeLine():
	dialogBoxLabel.percent_visible = 1
	canGoToNextLine = true
	canCompleteLine = false
	
# Retorna a porcentagem do texto que deve ficar visível a cada rodada do timer com base no tamanho do texto
func getPercentVisibleStepByText(text):
	var percentVisible = 0.01
	if(len(dialogBoxLabel.text) < 30):
		percentVisible = 0.03
	elif len(dialogBoxLabel.text) >= 30 && len(dialogBoxLabel.text) <= 60:
		percentVisible = 0.02
		
	return percentVisible

# Função que executa a lógica de complete das linhas se não estiver pausado
func _on_Timer_timeout():
	if startedDialog && !GlobalOptions.isPaused:
		if(dialogBoxLabel.percent_visible >= 1):
			canGoToNextLine = true
			$AudioStreamPlayer2D.stop()
		else:
			if canCompleteLine:
				completeLine()
				$AudioStreamPlayer2D.play()				
			else:
				$AudioStreamPlayer2D.play()
				dialogBoxLabel.percent_visible += getPercentVisibleStepByText(dialogBoxLabel.text)
			
# Função que recebe eventos do teclado para o popup de fala SE não estiver pausado
func _unhandled_key_input(event):
	if !GlobalOptions.isPaused:
		if Input.is_action_just_pressed("interact") && startedDialog:
			if(canGoToNextLine):
				showNextMessageOnList()
			else:
				canCompleteLine = true
