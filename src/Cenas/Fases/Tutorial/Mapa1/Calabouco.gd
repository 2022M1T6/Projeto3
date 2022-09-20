extends Node2D

var onDellsonArea = false

var dellsonDialog = false



func _ready():
	
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(float($AudioStreamPlayer2D.volume_db))
	$Player/PunchSound.volume_db = GlobalOptions.setSFXSound(float($Player/PunchSound.volume_db))
	$Player/RunningSound.volume_db = GlobalOptions.setSFXSound(float($Player/RunningSound.volume_db))
	$Player/WalkingSound.volume_db = GlobalOptions.setSFXSound(float($Player/WalkingSound.volume_db))
	$Dellson.setInteraction(1)
	$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem': 'jose',
				'falas': [
					'Uooou. Esse treinamento é REALMENTE imersivo.'
				]
			},
			{
				'personagem': 'dellson',
				'falas': [
					'Ei, você!',
					'Você mesmo com cara de bobão!',
					'Preciso falar com a Fabi para ter pelo menos um tutorial de como se mexer antes dos novatos chegarem aqui…',
					'Mas ainda bem que você tem…',
					'EEEU DELLSON! Seu capitão! Ou comandante!'
				]
			},
			{
				'personagem': 'fabiana',
				'falas': [
					'Instrutor, Dellson. Instrutor.'
				]
			},
			{
				'personagem': 'dellson',
				'falas': [
					'Pode ser, Fabi, pode ser…',
					'Vem cá, novato. EU serei seu mestre dos magos',
					'...',
					'Ah é, você se movimenta com WASD',
					'Venha até aqui para saber mais.'
				]
			}
		])

# Ao entrar na área, muda a cena
func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa2/Labirinto.tscn")

func _on_Area2DDellson_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	$Dellson.setState(1)
	$Player/Camera2D/CanvasLayer/Hint.hideHint()
	onDellsonArea = true

func _on_Area2DDellson_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	$Player/Camera2D/CanvasLayer/Hint.sendHint('Vá até a próxima área atrás de Dellson')
	$Dellson.setState(0)
	onDellsonArea = false

func sendDellsonDialog():
	if dellsonDialog:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas': [
						'Vai ali atrás campeão'
					]
				}
			])
	else:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas': [
						'Aff… Eu preciso falar com a Fabi sobre esse algoritmo de spawn.',
						'Então, novato, aqui você irá aprender sobre as dimensões do modelo de produto. Ao total são 9. N. O. V. E. Você sabe contar?'
					]
				},
				{
					'personagem': 'jose',
					'falas': [
						'Sim, Dellson. Você não precisa me explicar TUUUUDO'
					]
				},
				{
					'personagem': 'dellson',
					'falas': [
						'Ahã! Sabia que você é um cara inteligente.',
						'Bom, continuando… São 9 dimensões. Então, você terá 9 desafios para completar aqui. Para vencer cada um dos desafios,',
						'Você terá que utilizar um conceito da dimensão que ele representa. Ou seja, você só sai daqui se aprender!!!',
						'Legal, né? Eu que tive a ideia. Agora avance para a próxima área para continuarmos com o treinamento..'
					]
				}
		])
		dellsonDialog = true
		$Dellson.setInteraction(0)

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		if onDellsonArea:
			sendDellsonDialog()

func _on_TurorialArea1_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	$Player/Camera2D/CanvasLayer/Hint.sendHint('Procure e vá até Dellson')
