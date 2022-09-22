extends Control

func _ready():
	if GlobalOptions.isPortuguese:
		$TextureRect/Label.text = "Carregando..."
	else:
		$TextureRect/Label.text = "Loading..."
