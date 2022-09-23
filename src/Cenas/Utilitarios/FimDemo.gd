extends Node2D

func _ready():
	if GlobalOptions.isPortuguese:
		$Label.text = "Obrigado!"
	else:
		$Label.text = "Thanks!"
