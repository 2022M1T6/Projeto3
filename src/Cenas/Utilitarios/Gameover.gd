extends Node2D


func _ready():
	$AnimationPlayer.play("GameOverFade")
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-5)
	if GlobalOptions.isPortuguese:
		$Gameover/Label.text ='Fim de Jogo'
		$TextureButton/Label.text = "Tentar \nnovamente"
		$TextureButton2/Label.text = "Menu inicial"
	else:
		$Gameover/Label.text ='Game Over'
		$TextureButton/Label.text = "Try again"
		$TextureButton2/Label.text = "Main menu"

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Cenas/Fases/Quiz.tscn")


func _on_TextureButton2_pressed():
	get_tree().change_scene("res://Cenas/Menus/MenuPrincipal.tscn")
