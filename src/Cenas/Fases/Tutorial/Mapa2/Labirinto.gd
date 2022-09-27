extends Node2D

var first = false
# Vai para a próxima área
func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa3/Combate.tscn")

# Seta a fala ao entrar no mapa
func _ready():
	$Player/PunchSound.volume_db = GlobalOptions.setSFXSound(float($Player/PunchSound.volume_db))
	$Player/RunningSound.volume_db = GlobalOptions.setSFXSound(float($Player/RunningSound.volume_db))
	$Player/WalkingSound.volume_db = GlobalOptions.setSFXSound(float($Player/WalkingSound.volume_db))
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem': 'dellson',
				'falas': [
					'Eu fiquei com preguiça de terminar essa área, então fiz o upload de um mapa da Internet mesmo. Espero que você não fique assustado…',
					'hehe'
				]
			},
		])
	else:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem': 'dellson',
				'falas': [
					'I was too lazy to finish this area so I uploaded a map from the internet. Hope you don’t get scared…',
					'hehe'
				]
			},
		])

# Seta a hint ao sair da primeira area 2D
func _on_TutorialMapa2Fala1_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/Hint.sendHint('Vá até o final do labirinto')
	else:
		$Player/Camera2D/CanvasLayer/Hint.sendHint('Travese the labyrinth')


func _on_TutorialMapa2Fala2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	$TutorialMapa2Fala2.queue_free()
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas': [
						'BOO!!',
						'Errei o timing?',
						'… Enfim, quando você se deparar com longas caminhadas, pressione SHIFT para correr.'
					]
				}
		])
	else:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas': [
						'BOO!!',
						'Bad timing?',
						'…Anyway, when you find yourself in a long walk, press SHIFT to run.'
					]
				}
		])
