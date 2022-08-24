extends PopupDialog

onready var label = $"Barra-de-dialogo-dellson/Label"

var dialogos = []

func mostrarMensagem() -> void:
	if dialogos.size() == 0:
		hide()
		return
	
	var text = dialogos.pop_front()
	label.visible_characters = 0
	label.text = text
	print('to mostrando')
	show()
	return
	

func _on_Timer_timeout():
	label.visible_characters += 1


func _on_Area2D_area_entered(area):
	dialogos = [
		'Ei, você!',
		'Você mesmo com cara de bobão!',
		'Preciso falar com a Fabi para ter pelo menos um tutorial de como se mexer antes dos novatos chegarem aqui…',
		'Mas ainda bem que você tem…',
		'EEEU DELLSON! Seu capitão! Ou comandante!'
	]
	print('oi')
	mostrarMensagem()
