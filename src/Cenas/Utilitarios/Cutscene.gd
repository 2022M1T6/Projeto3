extends Node2D


func _ready():
	if GlobalOptions.isPortuguese:
		$Label.text = 'O vídeo foi aberto em seu navegador\nPressione E para continuar'
		OS.shell_open("https://youtu.be/RwOVy2hh93U")
	else:
		$Label.text = 'The video has been opened on your browser\nPress E to continue'
		OS.shell_open("https://youtu.be/JMVG3NpSRYo")

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa1/Calabouco.tscn")
	$VideoPlayer.volume_db = GlobalOptions.setMusicSound(0)
