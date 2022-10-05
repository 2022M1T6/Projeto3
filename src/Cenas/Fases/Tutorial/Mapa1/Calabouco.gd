extends Node2D

# Está na área de ação do Dellson
var onDellsonArea = false

# Já fez o diálogo do Dellson
var dellsonDialog = false


# Ao sair da primeira área do game, muda o texto da hint
func _on_TurorialArea1_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if !dellsonDialog:
		if GlobalOptions.isPortuguese:
			$Player/Camera2D/CanvasLayer/Hint.sendHint('Procure e vá até Dellson')
		else:
			$Player/Camera2D/CanvasLayer/Hint.sendHint('Go after Dellson')
	


# Ao entrar na área, muda a cena
func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if dellsonDialog:
		get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa2/Labirinto.tscn")

# Ao entrar na área do Dellson, muda o estado dele e esconde a hint
func _on_Area2DDellson_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	$Dellson.setState(1)
	onDellsonArea = true

# Ao sair da área do Dellson, muda o estado dele para o padrão e muda o texto da hint
func _on_Area2DDellson_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/Hint.sendHint('Vá até a próxima área (atrás de Dellson)')
	else:
		$Player/Camera2D/CanvasLayer/Hint.sendHint('Go to the next area (behind Dellson)')
	$Dellson.setState(0)
	onDellsonArea = false

# Envia o diálogo do Dellson
func sendDellsonDialog():
	if GlobalOptions.isPortuguese:
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
							'Legal, né? Eu que tive a ideia. Agora avance para a próxima área para continuarmos com o treinamento.'
						]
					}
			])
			dellsonDialog = true
			$Dellson.setInteraction(0)
	else:
		if dellsonDialog:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'dellson',
						'falas': [
							'Behind me, champ.'
						]
					}
				])
		else:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'dellson',
						'falas': [
							'Oof… why do these newbies have to spawn so far away.',
							'So, newbie, here you’ll learn about the product model’s 9 dimensions. There are 9 of them… 9. N I N E, can you count?'
						]
					},
					{
						'personagem': 'jose',
						'falas': [
							'Yes, Dellson. There’s no need to explain EVERYTHING.'
						]
					},
					{
						'personagem': 'dellson',
						'falas': [
							'Aha! I knew you were a smarty pants.',
							'So… there are 9 dimensions, therefore you’ll have 9 challenges, you’ll need to use the concept of the represented dimension.',
							'In other words, the only way out is learning!!',
							'Cool, huh? I had this idea by myself. Now go on to the next area for us to continue with the training.'
						]
					}
			])
			dellsonDialog = true
			$Dellson.setInteraction(0)


func _ready():
	GlobalOptions.setItemsToHideOnDialog([
		$Player/Camera2D/CanvasLayer/Hint,
		$Player/Camera2D/CanvasLayer/KeyboardKeys
	])
	# Define a interação com1
	$Dellson.setInteraction(1)
	
	# Envia o primeiro diálogo
	if GlobalOptions.isPortuguese:
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
	else:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'jose',
					'falas': [
						'Oh shit, here we go again.'
					]
				},
				{
					'personagem': 'dellson',
					'falas': [
						'Hey, you!',
						'Yeah, I’m talking to you, boy!',
						'Damn, I need to tell Fabi to give you a tutorial before you start this program.',
						'But lucky you, you have...',
						'Meeeee, Dellson, as your captain!'
					]
				},
				{
					'personagem': 'fabiana',
					'falas': [
						'Instructor, Dellson. Instructor.'
					]
				},
				{
					'personagem': 'dellson',
					'falas': [
						'Okay, Fabi, okay.',
						"Come here newbie. I'll be you Dungeon Master",
						'...',
						'Oh, almost forgot, you move using WASD. Come here to know more!'
					]
				}
		])


# Verifica os inputs do teclado
func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		if onDellsonArea:
			sendDellsonDialog()

func _process(delta):
	GlobalFase2.paralax($Player,$Dellson)
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-20)

func _on_Area2D_area_entered(area):
	pass # Replace with function body.
