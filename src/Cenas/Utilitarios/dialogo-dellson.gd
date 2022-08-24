extends PopupDialog

onready var label = $TextureRect/Label
var podeIrParaProximaLinha = false
var dialogos = []

func mostrarMensagem() -> void:
	if dialogos.size() == 0:
		get_tree().paused = false
		hide()
		return
	
	var text = dialogos.pop_front()
	label.percent_visible = 0
	label.text = text
	podeIrParaProximaLinha = false
	show()
	return
	
func _process(delta):
	if podeIrParaProximaLinha && Input.is_action_just_pressed("interact"):
		mostrarMensagem()

func _on_Timer_timeout():
	if(label.percent_visible >= 1):
		podeIrParaProximaLinha = true
	else:
		var percentVisible = 0.01
		if(len(label.text) < 30):
			percentVisible = 0.03
		elif len(label.text) >= 30 && len(label.text) <= 60:
			percentVisible = 0.02
			
		label.percent_visible += percentVisible


func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	dialogos = [
		'Ei, você!',
		'Você mesmo com cara de bobão!',
		'Preciso falar com a Fabi para ter pelo menos um tutorial de como se mexer antes dos novatos chegarem aqui…',
		'Mas ainda bem que você tem…',
		'EEEU DELLSON! Seu capitão! Ou comandante!'
	]
	
	get_tree().paused = true
	mostrarMensagem()
