extends Node2D

var diag1 = false


func _ready():
	GlobalOptions.setItemsToHideOnDialog([
		$Player/Camera2D/CanvasLayer/Hint,
		$Player/Camera2D/CanvasLayer/WeaponFrame,
		$Player/Camera2D/CanvasLayer/DimensionFrame
	])
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/Hint/HintText.text = 'Avance para a próxima fase'
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"CARAMBA, O QUE FOI AQUILO?",
					'...',
					'Vamos continuar.'
				]
			}
		])
	else:
		$Player/Camera2D/CanvasLayer/Hint/HintText.text = 'Go to the next level'
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"WHAT WAS THAT?",
					'...',
					"Let's continue."
				]
			}
		])
	

func _process(delta):
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-5)
	if diag1:
		$Area2D.monitorable = false
		$Area2D.monitoring = false
	
	


func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	diag1 = true
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"Eai amigão, tudo bem?",
					"Agora quero te dar os parabéns por concluir a fase 2 com êxito, sei que não deve ter sido uma tarefa fácil, tiveram alguns obstáculos para chegar até aqui, mas esses obstáculos serviram como lições.",
					"Espero que você tenha compreendido que um roteiro prévio é sempre útil para atingir um objetivo, mesmo que ocorram empecilhos, o guia mesmo sofrendo alterações ajuda você a se organizar e se planejar, espero que com essa fase você tenha compreendido isso.",
					"Isso que acabei de resumir para você, no modelo de produto é chamado de 'Roadmap'.",
					
				]
			}
		])
	else:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"Hey mate, are you alright?",
					"Now I must congrat you for successfully finishing level 2, I kown it probably wasn't an easy task for there were some obstacles to get here but they served as a lesson.",
					"I hope you've understood that making a previous script is always useful for achieving your objective. Even if there were obstacles that made the need to change the guide, it helped you organize and plan ahead.",
					"What I just sumarized for you, in product model, is called 'Roadmap'."
				]
			}
		])
	


func _on_Area2D_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	$Player/Camera2D/CanvasLayer/WeaponFrame.show()


func _on_Area2D2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://Cenas/Fases/Quiz.tscn")
