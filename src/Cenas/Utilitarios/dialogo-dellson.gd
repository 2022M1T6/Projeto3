extends PopupDialog

onready var dialogBoxLabel = $DialogBox/Label
var podeIrParaProximaLinha = false
var completarFrase = false

var dialogos = []
var dialogoAtual = {"personagem": "", "falas": []}


func getDialogSpriteFilePath():
	if dialogoAtual["personagem"] == 'dellson':
		return "res://Public/dellsonCaixaDialogo.png"
	elif dialogoAtual["personagem"] == 'jose':
		return "res://Public/Jose.png"
	
	return "res://Public/icon.png"
		
# Função que mostra a próxima mensagem do array de diálogos
func mostrarMensagem() -> void:
	if dialogoAtual["falas"].size() == 0 && dialogos.size() == 0:
		get_tree().paused = false
		hide()
		return
	
	if(dialogoAtual["falas"].size() == 0):
		dialogoAtual = dialogos.pop_front()
	
	var text = dialogoAtual["falas"].pop_front()	
	dialogBoxLabel.percent_visible = 0
	dialogBoxLabel.text = text
	podeIrParaProximaLinha = false

	# Verifica se a foto da caixa de diálogo está condizente com o personagem e troca caso necessário
	$DialogSprite.texture = load(getDialogSpriteFilePath())

	show()
	return
	
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if(podeIrParaProximaLinha):
			mostrarMensagem()
		else:
			completarFrase = true

func _on_Timer_timeout():
	if(dialogBoxLabel.percent_visible >= 1):
		podeIrParaProximaLinha = true
	else:
		if completarFrase:
			dialogBoxLabel.percent_visible = 1
			podeIrParaProximaLinha = true
			completarFrase = false
		else:
			var percentVisible = 0.01
			if(len(dialogBoxLabel.text) < 30):
				percentVisible = 0.03
			elif len(dialogBoxLabel.text) >= 30 && len(dialogBoxLabel.text) <= 60:
				percentVisible = 0.02
				
			dialogBoxLabel.percent_visible += percentVisible


func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	dialogos = [
		{
			'personagem': 'jose',
			'falas': [
				'Uooou. Esse treinamento é REALMENTE imersivo.'
			]
		},
		{
			'personagem': 'dellson',
			'falas': [
				'Ei, você!',
				'Você mesmo com cara de bobão!',
				'Preciso falar com a Fabi para ter pelo menos um tutorial de como se mexer antes dos novatos chegarem aqui…',
				'Mas ainda bem que você tem…',
				'EEEU DELLSON! Seu capitão! Ou comandante!'
			]
		},
		{
			'personagem': 'fabiana',
			'falas': [
				'Instrutor, Dellson. Instrutor.'
			]
		},
		{
			'personagem': 'dellson',
			'falas': [
				'Pode ser, Fabi, pode ser…',
				'Vem cá, novato. EU serei seu mestre dos magos',
				'*Pausa',
				'Ah é, você se movimenta com WASD',
				'Venha até aqui para saber mais.'
			]
		}
	]
	mostrarMensagem()
	get_tree().paused = true
