extends Node2D

func _ready():
	# Troca o texto de acordo com a lingua
	if GlobalOptions.isPortuguese:
		$Label.text = "Obrigado!"
	else:
		$Label.text = "Thanks!"
