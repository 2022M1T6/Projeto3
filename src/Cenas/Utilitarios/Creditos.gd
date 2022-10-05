extends Node2D

func _ready():
	$AnimationPlayer.play("gallo")
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-10)
	if GlobalOptions.isPortuguese:
		$TextureButton/Label.text = "Voltar ao\nmenu inicial"
		$Agradecimento.text = 'Obrigado por jogar!!!'
		$Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"Você... completou o meu quiz!!!",
					'PARABÉNS!! Este é um passo para entender o modelo de produto.',
					'Infelizmente, minha memória está quase cheia e minha bateria está quase acabando. Então está na hora de me despedir.',
					'Muito obrigado por jogar, espero que voccê tenha gostado!'
				]
			}
		])
	else:
		$TextureButton/Label.text = "Return to\nmain menu"
		$Agradecimento.text = 'Thanks for playing!!!'
		$Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"You... completed my quiz!!!",
					'CONGRATS!! This is a step to understand the product model',
					"Unfortunately, my memory is almost full and my battery is at it's lasts straws. So it's time to say goodbye.",
					'Thanks for playing and I hope you had fun!'
				]
			}
		])

func _process(delta):
	if $Nomes.rect_position.y > -3100:
		$Nomes.rect_position.y -= 1
		$Logo.position.y -= 1
	elif $Nomes.rect_position.y == -3100:
		$AnimationPlayer.play("Fade")
		$Nomes.rect_position.y -= 1
		
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-10)


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Cenas/Menus/MenuPrincipal.tscn")
