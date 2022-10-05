extends Node2D


func _ready():
	if GlobalOptions.isPortuguese:
		$Label.text = 'Pressione E para\npular a cutscene'
		$VideoPlayer.stream = load("res://Public/Video/cutscenePortugues.ogv")
	else:
		$Label.text = 'Press E to skip\nthe cutscene'
		$VideoPlayer.stream = load("res://Public/Video/cutsceneIngles.ogv")
	$VideoPlayer.play()

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa1/Calabouco.tscn")
	$VideoPlayer.volume_db = GlobalOptions.setMusicSound(0)
	
func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa1/Calabouco.tscn")
