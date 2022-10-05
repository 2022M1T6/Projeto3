extends Node2D
onready var camera = $Player/Camera
var isOnPlayerCamera = true
var enteredSwordsmanArea = false
var enteredGalloArea = false
var enteredSwordArea = false
var enteredDellsonArea = false
var enteredResetDiag = false
var enteredDash = false

var onSword = false
var onSwordsman = false
var talkedSwords = false
var talkedWithSwordsman = false
var talkedWithGallo = false
var change = 0

# Envia os diálogos do swordsman
func sendSwordsmanDialog():
	if !talkedWithSwordsman:
		talkedWithSwordsman = true
		if GlobalOptions.isPortuguese:
			$Player/Camera/CanvasLayer/Hint.sendHint("Recupere a espada do espadachim nas ilhas ao sul")
		else:
			$Player/Camera/CanvasLayer/Hint.sendHint("Retrieve the swordsman's sword in the south islands")
		$Swordsman.setInteraction(0)
		if GlobalOptions.isPortuguese:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "swordsman",
					"falas": [
						'Olá, player!',
						'Eu não sei o que ocorreu direito, do nada um terremoto aconteceu e tem água por tudo agora!',
						'No meio do desastre, minha espada voou para o Sul daqui. Vi que você está construindo seu caminho entre as ilhas, com a ajuda de minha espada conseguiremos sair daqui!'
					]
				},
				{
					"personagem": "dellson",
					"falas": [
						"Você escutou o cara... atrás da espada dele!"
					]
				},
				{
					"personagem": "swordsman",
					"falas": [
						"E... eu vou com você, tudo bem? Não quero ficar sozinho aqui hehe"
					]
				}
			])
		else:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "swordsman",
					"falas": [
						'Hello, player!',
						"I don't know what happened exactly but suddenly there was an earthquake and now there's water all around",
						'During this disaster my sword flew south. I saw you building your path between islands, with the help of my sword we can get out of here!'
					]
				},
				{
					"personagem": "dellson",
					"falas": [
						"You heard it dude... go after his sword."
					]
				},
				{
					"personagem": "swordsman",
					"falas": [
						"And I'm coming with you if that's okay. I don't want to be lonely here hehehe"
					]
				}
			])

# Envia o diálogo do Gallo
func sendGalloDialog():
	if !talkedWithGallo:
		talkedWithGallo = true
		if GlobalOptions.isPortuguese:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "gallo",
					"falas": [
						"Po pó pó pó."
					]	
				},
				{
					"personagem": "dellson",
					"falas": [
						"O Gallo mandou saudações e espera poder ajudar você nessa aventura."
					]	
				},
				{
					"personagem": "gallo",
					"falas": [
						"Có có ri có"
					]
				},
				{
					"personagem": "dellson",
					"falas": [
						"O Gallo disse que voce precisa se atentar, perceber que ao longo do caminho seu roteiro pode ter que mudar, e será preciso estar preparado para mudanças!"
					]	
				},
			])
		else:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "gallo",
					"falas": [
						"Po po po po."
					]	
				},
				{
					"personagem": "dellson",
					"falas": [
						"Gallo, The Rooster, greets you and wish to help in your journey."
					]	
				},
				{
					"personagem": "gallo",
					"falas": [
						"Co co ri co"
					]
				},
				{
					"personagem": "dellson",
					"falas": [
						"Gallo, The Rooster, says you need to pay attention and notice that during your journey your script might change, therefore you need to be prepared for incoming changes!"
					]	
				},
			])
	else:
		if GlobalFase2.hasSword:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "gallo",
					"falas": [
						"Po pó po po!"
					]	
				}
			])
		else:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "gallo",
					"falas": [
						"Po pó po po....",
						"Po pó pó."
					]	
				}
			])

# Envia o diálogo do Dellson
func sendDellsonDialog():
	if GlobalOptions.isPortuguese:
		$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"Eai amigão, tudo bem?",
					"Agora quero te dar os parabéns por concluir a fase 2 com sucesso, sei que não deve ter sido uma tarefa fácil, tiveram alguns obstáculos para chegar até aqui, mas esses obstáculos serviram como lições.",
					"Espero que você tenha compreendido que um roteiro prévio é sempre útil para atingir um objetivo, mesmo que ocorram empecilhos, o guia mesmo sofrendo alterações ajuda você a se organizar e se planejar. Espero que com essa fase você tenha compreendido isso.",
					'Isso que acabei de resumir para você, no modelo de produto é chamado de “Roadmap”.'
				]
			}
		])
	else:
		$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"Hey friend are you okay?",
					"Now I want to congrat you for finishing level 2, I know it probably wasn't an easy job, there were many obstacles to get here, but they served as a lesson",
					"I hope you've learned that a previous script is always useful for achieving something, even if there are obstacles the guide helps you organize and plan ahead. I hope you've learned it.",
					'What I just explained, in product model, is called "Roadmap".'
				]
			}
		])

# Envia o diálogo do Swordsman após pegar a espada
func sendSwordsmanDialogWhenPickupSword():
	$Sword.queue_free()
	GlobalFase2.hasSword = true
	if GlobalOptions.isPortuguese:
		$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "swordsman",
				"falas": [
					"Ahã! Sabia que você iria conseguir!",
					"Com essa espada, você conseguirá usar um feitiço para pular entre distancias pequenas!"
				]
			},
			{
				"personagem": "jose",
				"falas": [
					"Legal! Eu acho que vou precisar usar para conseguir ir até o lado oeste e sair dessas ilhas"
				]
			}
		])
	else:
		$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "swordsman",
				"falas": [
					"Aha! I knew you'd make it!",
					"With this sword you'll be able to dash and jump over small obstacles!"
				]
			},
			{
				"personagem": "jose",
				"falas": [
					"Cool! I think I'll need it to get to the western island and get out of here."
				]
			}
		])

func sendDialogSwordWithoutTalkedWithSwordsman():
	if GlobalOptions.isPortuguese:
		$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "jose",
				"falas": [
					"Uma espada...",
					"Acho que alguém pode ter perdido ela"
				]
			}
		])
	else:
		$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "jose",
				"falas": [
					"A sword...",
					"Somebody may have lost it"
				]
			}
		])
		
# Pega a espada do cenário
func getSword():
	if talkedWithSwordsman:
		GlobalFase2.hasSword = true
		$Sword.queue_free()
		if GlobalOptions.isPortuguese:
			$Player/Camera/CanvasLayer/Hint.sendHint("Atravesse até o próximo lado")
		else:
			$Player/Camera/CanvasLayer/Hint.sendHint("Go to the other side.")

func changePlayerCamera():
	if isOnPlayerCamera:
		camera.zoom = Vector2(1.2,1.2)
		isOnPlayerCamera = false
	else:
		camera.zoom = Vector2(0.3,0.3)
		isOnPlayerCamera = true

func _process(delta):
	$Player/Camera/CanvasLayer/WoodCountFrame/WoodCountLabel.text = " x " + str(GlobalFase2.wood)
	if Input.is_action_just_pressed("Reload"):
		reset()
	for i in range(1,7):
		GlobalFase2.paralax($Player,get_node('Tree'+str(i)))
	
	GlobalFase2.paralax($Player,$Gallo)
	GlobalFase2.paralax($Player,$Swordsman)
	GlobalFase2.paralax($Player,$Sword)
	
	if enteredDash && GlobalFase2.hasSword:
		$TeclaE.show()
		if Input.is_action_just_pressed("interact"):
			$Player.hide()
			$Player.position += Vector2(40,0)
			$AnimationPlayer.play("New Anim")
			yield(get_tree().create_timer(0.2),"timeout")
			$Player.show()
	else:
		$TeclaE.hide()
	
	if GlobalFase2.hasSword:
		if GlobalOptions.isPortuguese:
			$Player/Camera/CanvasLayer/Hint.sendHint("Atravesse até o próximo lado")
		else:
			$Player/Camera/CanvasLayer/Hint.sendHint("Go to the other side.")
# Ao entrar na área de ação do Swordsman, ativa o estado de ação do NPC e registra que o jogador está dentro da área
func _on_Swordsman2_area_entered(area):
	enteredSwordsmanArea = true
	$Swordsman.setState(1)

# Ao sair da área de ação do Swordsman, desativa o estado de ação do NPC e registra que o jogador saiu de dentro da área
func _on_Swordsman2_area_exited(area):
	enteredSwordsmanArea = false
	$Swordsman.setState(0)
	if talkedWithSwordsman:
		$Swordsman.queue_free()
	
# Muda o estado da espada quando entra em sua área de ação
func _on_actionArea_area_entered(area):
	enteredSwordArea = true
	$Sword.setState(1)

# Muda o estado da espada quando sai em sua área de ação
func _on_actionArea_area_exited(area):
	enteredSwordArea = false
	$Sword.setState(0)

# Muda o estado do gallo quando entra em sua área de ação
func _on_GalloArea_area_entered(area):
	enteredGalloArea = true
	$Gallo.setState(1)

# Muda o estado do gallo quando sai em sua área de ação
func _on_GalloArea_area_exited(area):
	enteredGalloArea = false
	$Gallo.setState(0)

func _ready():
	GlobalOptions.setItemsToHideOnDialog([
		$Player/Camera/CanvasLayer/Hint,
		$Player/Camera/CanvasLayer/WeaponFrame,
		$Player/Camera/CanvasLayer/WoodCountFrame,
		$Player/Camera/CanvasLayer/DimensionFrame
	])
	
	$Swordsman.setInteraction(1)
	if !GlobalFase2.hasReset:
		if GlobalOptions.isPortuguese:
			$Player/Camera/CanvasLayer/Hint.sendHint("Colete madeira, construa pontes e atravesse até o outro lado")	
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "dellson",
					"falas": [
						"Jovem padawan, agora você deve continuar sua jornada, em busca do conhecimento, deve superar os obstáculos e chegar do outro lado do desfiladeiro."
					]
				},
				{
					"personagem": "jose",
					"falas": [
						"Ora, Dellson, como passerei por todas essas ilhas? Mesmo que eu conseguisse pular, não seria forte o bastante."
					]
				},
				{
					"personagem": "dellson",
					"falas": [
						"Você tem um machado e existem árvores, é só você cortá-las e construir pontes improvisadas com elas.",
						"Lembre-se de planejar o caminho e o material disponível, pense em como as árvores estão dispostas e que uma árvore rende apenas duas pontes, o improviso pode ser sua ruína.",
						"Visualizar, planejar, gerir recursos e possibilidades... Tudo isso é roadmap.",
						"Agora leve-nos para o outro lado"
					]
				}
			])
		else:
			$Player/Camera/CanvasLayer/Hint.sendHint("Gather wood to build bridges and get to the other side")	
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "dellson",
					"falas": [
						"Young padawan, now you must continue your journey in search of knowledge. You must overcome the obstacles and get to the other side of the Canyon."
					]
				},
				{
					"personagem": "jose",
					"falas": [
						"Well, Dellson, how will I go over all these islands? Even if I could jump it wouldn't be strong enough."
					]
				},
				{
					"personagem": "dellson",
					"falas": [
						"You have an ax and there are trees, you may cut them in order to build bridges, improvising with them.",
						"Remember to plan your path and available material, think of how the trees are disposed and that one tree yields only two bridges, improvising can be your ruin.",
						"Visualize, plan, manage resources and possibilities... All this is roadmap.",
						"Now take us to the other side."
					]
				}
			])

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		if enteredSwordsmanArea:
			sendSwordsmanDialog()
		elif enteredSwordArea:
			if talkedWithSwordsman:
				sendSwordsmanDialogWhenPickupSword()
			else:
				sendDialogSwordWithoutTalkedWithSwordsman()
		elif enteredGalloArea:
			sendGalloDialog()
		elif enteredDellsonArea:
			sendDellsonDialog()
	
	if Input.is_action_just_pressed("V"):
		changePlayerCamera()
			
	return event


func _on_finalDialog_area_entered(area):
	GlobalOptions.dimensoes["roadmap"] = true
	get_tree().change_scene("res://Cenas/Utilitarios/FimDemo.tscn")

func reset():
	get_tree().reload_current_scene()
	GlobalFase2.hasReset = true
	GlobalFase2.wood = 2
	GlobalFase2.hasSword = false


func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if !enteredResetDiag:
		if GlobalOptions.isPortuguese:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "dellson",
					"falas": [
						"Ah, quase esquci de te avisar que se você pressionar V, você consegue trocar o zoom da câmera para planejar melhor seu próximo passo.",
						"E caso voçê tenha feito algum erro, pressione R para reiniciar o puzzle. Útil, não?"
					]
				}
			])
		else:
			$Player/Camera/CanvasLayer/PopupDialog.sendDialog([
				{
					"personagem": "dellson",
					"falas": [
						"Oh, almost forgot to tell you that if you press V, you can change the camera's zoom to plan your moves better.",
						"And if you find yourself stuck, you can press R to restart the puzzle. Usefull, am I right?",
					]
				}
			])
		enteredResetDiag = true



func _on_Dash_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	enteredDash = true
	


func _on_Dash_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	enteredDash = false
