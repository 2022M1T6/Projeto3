extends Node2D

var dialog = false

func _ready():
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/Hint.sendHint("Avance para a próxima fase")
		$Player/Camera2D/CanvasLayer/DimensionFrame/Label.text = 'Visão'
	else:
		$Player/Camera2D/CanvasLayer/Hint.sendHint("Go to the next level")
		$Player/Camera2D/CanvasLayer/DimensionFrame/Label.text = 'Vision'

func _process(delta):
	if dialog:
		$Area2D.monitoring = false
		$Area2D.monitorable = false
		$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-5)

func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	dialog = true
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem':'dellson',
				'falas':[
					'FINALMENTE UM POUCO DE SOL',
					'Agora que você saiu do tutorial, os desafios vão realmente começar!',
					'O ícone no canto superior direito mostra qual dimensão está sendo analisada em cada fase. E ao completá-la, você poderá ler uma descrição mais detalhada da dimensão no menu de pausa.',
					'Dito isso, avante!'
				]
			}
		])
	else:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem':'dellson',
				'falas':[
					'FINALLY SOME SUNLIGHT',
					"Now that you're out of the tutorial, the challenges will start!",
					"The icon on top-left corner will show which dimension is being tested in each level. After you fininsh it, you'll be able to read a detailed summary of the dimension on the pause menu.",
					"That said, let's-a go!"
				]
			}
		])



func _on_Area2D2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://Cenas/Fases/Fase1/Fase.tscn")
