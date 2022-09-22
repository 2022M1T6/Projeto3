extends Node2D

var enteredTreeArea = false
var enteredBlacksmithArea = false
var enteredLumberjackArea = false
var enteredKingArea = false
var enteredMarketerArea = false
var removedTree = false
var endGameSetedUp = false # Guarda se o setup das configurações de pós-minigame concluido foram feitos

var fase1Dialog = {"marketer": false, "king": false, "lumberjack": false, "blacksmith": false}

# Função que verifica se o tronco caído pode ser retirado
func verifyAndRemoveTree():
	if Input.is_action_just_pressed("punch") && enteredTreeArea && !removedTree:
		if GlobalFase1.AxeOk:
			$TreeAndRocks/Treelog.queue_free()
			removedTree = true
		else: 
			$Player/Camera2D/CanvasLayer/WeaponFrame.hide()
			if GlobalOptions.isPortuguese:
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'dellson',
						'falas': [
							'Hmm... Parece que esse machado não vai funcionar tão bem. Tente colher informações com os residentes e montar outro machado na casa do ferreiro!'
						]
					}
				])
			else:
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'dellson',
						'falas': [
							"Hmm... looks like this axe won't do for the job. Try getting more info with the villagers and build another axe!"
						]
					}
				])

# Faz o envio dos diálogos do marketer
func sendMarketerDialog():
	if fase1Dialog.marketer:
		if GlobalOptions.isPortuguese:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem':'marketer',
						'falas':[
							'Lembre-se, entender o problema é a parte mais importante para resolvê-lo'
						]
					}
			])
		else:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem':'marketer',
						'falas':[
							'Remember, understanding the problem is the most important part of solving it'
						]
					}
			])
		$Marketer.setInteraction(0)
	else:
		fase1Dialog.marketer = true # Marca que o jogador já falou com o Marketer
		$Marketer.setInteraction(0) # Muda a interação do marketer para sem balão
		if !fase1Dialog.king:
			$King.setInteraction(1)
			if GlobalOptions.isPortuguese:
				$Player/Camera2D/CanvasLayer/Hint.sendHint("Verifique se o rei está com problemas")
			else:
				$Player/Camera2D/CanvasLayer/Hint.sendHint("Check if the king has any trouble")
		if GlobalOptions.isPortuguese:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([ # Envia o diálogo do marketer
				{
					'personagem': 'marketer',
					'falas': [
						'Ooh meu Deus, como eu queria ter essa idade novamente. Com a visão que tenho hoje eu poderia ter entendido melhor muitas coisas de minha vida.',
						'OPS, acabei falando alto, me desculpe e eu não me apresentei, prazer sou o Geraldo e você?'
					]
				},
				{
					'personagem': 'jose',
					'falas': [
						'Prazer me chamo José. Deixa eu te perguntar, você é vendedor também?'
					]
				},
				{
					'personagem': 'marketer',
					'falas': [
						'Sou sim, trabalho há 30 anos como vendedor.'
					]
				},
				{
					'personagem': 'jose',
					'falas':[
						'Há tanto tempo, e como o senhor faz para ter tanto sucesso?'
					]
				},
				{
					'personagem':'marketer',
					'falas':[
						'Tenho um segredo que é tentar compreender os problemas das pessoas e definir uma meta para resolvê-los, em resumo, ter visão.',
						'Assim eles se tornam meus clientes e compram muita comida HAHAHA!!'
					]
				}
			])
		else:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([ # Envia o diálogo do marketer
				{
					'personagem': 'marketer',
					'falas': [
						"Ooh my, I'd love to be this age again. With the vision I have today, there are many things I'd have understood better.",
						'OPS, did I say out loud? I’m sorry, I should introduce myself, I am Geraldo. You?'
					]
				},
				{
					'personagem': 'jose',
					'falas': [
						"I’m José. It's a pleasure to meet you. But let me ask you something… are you a salesman too?"
					]
				},
				{
					'personagem': 'marketer',
					'falas': [
						'Yes, I’ve been a salesman for about 30 years now.'
					]
				},
				{
					'personagem': 'jose',
					'falas':[
						"Wow! And what's the key to your success?"
					]
				},
				{
					'personagem':'marketer',
					'falas':[
						'I have a secret… you need to try understanding people’s problems and set a goal to resolve that, in short, having vision.', 
						'This way they become my clients and buy a lot of food HAHAHAHAHA!',
					]
				}
			])
		
# Faz o envio dos diálogos do king
func sendKingDialog():
	if fase1Dialog.king:
		if GlobalOptions.isPortuguese:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem':'king',
					'falas':[
						'Como está o progresso? Eu quero voltar para o meu castelo o quanto antes.'
					]
				}
			])
		else:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem':'king',
					'falas':[
						"How's the progress? I wanna go back to my castle ASAP." 
					]
				}
			])
	else:
		fase1Dialog.king = true
		$King.setInteraction(0) # Tira o balão do king
		if GlobalOptions.isPortuguese:
			$Player/Camera2D/CanvasLayer/Hint.sendHint("Procure informações afim de solucionar o problema do rei")
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([ # Envia o diálogo com king
				{
					'personagem': 'jose',
					'falas': [
						'Ei cara, tudo bem? Parece que você viu um fantasma'
					]
				},
				{
					'personagem': 'king',
					'falas': [
						'"CARA"????? COMO OUSA? SOU O REI GINALDO SEGUNDO',
						'Um fantasma não, mas suponho que seja alguma bruxaria! Esse tronco apareceu do nada.'
					]
				},
				{
					'personagem': 'dellson',
					'falas': [
						'(cochicho) Ops, eu renderizei ele sem querer…, vamos ajudar esse cara, fiquei com peso na consciência.'
					]
				},
				{
					'personagem': 'jose',
					'falas':[
						'(cochicha) Eu não, você que fez a besteira, então você que resolva'
					]
				},
				{
					'personagem':'dellson',
					'falas':[
						'(cochicho) Ok, deixa que eu resolvo',
						'Meu amigo aqui vai te ajudar a resolver isso, pode contar com ele'
					]
				},
				{
					'personagem': 'jose',
					'falas':[
						'O que, como as…'
					]
				},
				{
					'personagem':'king',
					'falas':[
						'Bom, precisamos dar um jeito de tirar essa tronco do nosso caminho'
					]
				},
				{
					'personagem':'jose',
					'falas':[
						'...',
						'Tá bom, vou pensar em algo'
					]
				},
			])
		else:
			$Player/Camera2D/CanvasLayer/Hint.sendHint("Search for info to solve the king's problem")
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([ # Envia o diálogo com king
				{
					'personagem': 'jose',
					'falas': [
						'Hey dude! Are you okay? It looks like you have seen a ghost!'
					]
				},
				{
					'personagem': 'king',
					'falas': [
						'"DUDE"???? HOW DARE YOU? I AM KING PRINCE THE SECOND',
						'Not a ghost… I suppose some witchcraft! This log appeared out of nowhere.'
					]
				},
				{
					'personagem': 'dellson',
					'falas': [
						'(whispers) Ops, I rendered it unintentionaly… let’s help this dude! I need to clear my conscience '
					]
				},
				{
					'personagem': 'jose',
					'falas':[
						'(whispers) Nop, that’s on you'
					]
				},
				{
					'personagem':'dellson',
					'falas':[
						'(whispers) Fine, I got this',
						"My friend is here to help you! He's very smart."
					]
				},
				{
					'personagem': 'jose',
					'falas':[
						'What the…'
					]
				},
				{
					'personagem':'king',
					'falas':[
						'Well, we need to take this log out of the way.'
					]
				},
				{
					'personagem':'jose',
					'falas':[
						'...',
						"Ok, I'll think of something"
					]
				},
			])
		$Marketer.setInteraction(0) # Seta a interação para sem balões para o marketer		
		$Blacksmith.setInteraction(1) # Seta o balão de missão para o blacksmith
		$Lumberjack.setInteraction(2) # Seta o balão de diálogo para o lumberjack
		
# Faz o envio dos diálogos do lumberjack
func sendLumberjackDialog():
	if fase1Dialog.king:
		if fase1Dialog.lumberjack:
			if GlobalOptions.isPortuguese:
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'lumberjack',
						'falas': [
							'Lembre-se, muitas vezes a ferramenta mais simples é a ideal para o problema'
						]
					}
				])
			else:
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'lumberjack',
						'falas': [
							'Remember, sometimes the best tool for the job is the simplest one.'
						]
					}
				])
		else:
			fase1Dialog.lumberjack = true
			if GlobalOptions.isPortuguese:
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'lumberjack',
						'falas': [
							'Hey garoto, o que faz aqui?'
							]
					},
					{
						'personagem': 'jose',
						'falas': [
							'Eu caí neste mundo para aprender melhor o modelo de produto, mas o rei está com problemas para chegar ao castelo, por conta destas árvores que estão impedindo o caminho.'
						]
					},
					{
						'personagem': 'lumberjack',
						'falas': [
							'Interessante, então quer dizer que você é amigo do Dellson!?'
						]
					},
					{
						'personagem': 'jose',
						'falas': [
							'Sim, ele é meu mentor!',
							'Por que você está com este machado nas mãos?'
						]
					},
					{
						'personagem': 'lumberjack',
						'falas': [
							'HAHA meu jovem, eu sou o melhor lenhador desta região. E se você precisar de ajuda para entender como quebrar uma árvore, eu te ajudarei.'
						]
					},
					{
						'personagem': 'jose',
						'falas': [
							'Qual dica você daria para um iniciante?'
						]
					},
					{
						'personagem': 'lumberjack',
						'falas': [
							'Pode parecer besta, mas as vezes, a ferramenta mais simples é a melhor para o trabalho',
							'Se um açougueiro não possuir uma faca boa, a carne que ele corta não ficará boa. Portanto, pense o que faz um machado bom para cortar árvores'
						]
					}
				])
			else:
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'lumberjack',
						'falas': [
							'Hey pal, whatcha doin hea?'
							]
					},
					{
						'personagem': 'jose',
						'falas': [
							"I've been sucked into this world to learn about product model, but the king have problems. The trees are blocking his way into the castle."
						]
					},
					{
						'personagem': 'lumberjack',
						'falas': [
							"Interesting, so you're tellin me that you are Dellson's friend?"
						]
					},
					{
						'personagem': 'jose',
						'falas': [
							'Yes… he is my mentor!',
							'Also, why are you holding an axe?'
						]
					},
					{
						'personagem': 'lumberjack',
						'falas': [
							'HAHA pal, I am the best lumberjack in the region! So if you need some help to understand how to take down a tree, I’ll help ya.'
						]
					},
					{
						'personagem': 'jose',
						'falas': [
							'Have some tips for a beginner?'
						]
					},
					{
						'personagem': 'lumberjack',
						'falas': [
							'May seem silly, but sometimes the simplest is the best for the job.',
							"If a butcher doesn't have a good knife, the meat he cuts won't be good. So think about what makes an axe good at cutting trees."
						]
					}
				])
	else:
		if GlobalOptions.isPortuguese:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'lumberjack',
					'falas': [
						'O rei parece estar com problemas, você pode ir falar com ele?'
					]
				}
			])
		else:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'lumberjack',
					'falas': [
						'The king seems to have a problem, could ya check it?'
					]
				}
			])
# Faz o envio dos diálogos do blacksmith
func sendBlacksmithDialog():
	if fase1Dialog.blacksmith:
		if GlobalOptions.isPortuguese:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'blacksmith',
					'falas': [
						'Você precisa de algo? Pode entrar na minha forja'
					]
				}
			])
		else:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'blacksmith',
					'falas': [
						"Do ya need somethin'? Fell free to enter my forge"
					]
				}
			])
	else:
		if fase1Dialog.king:
			fase1Dialog.blacksmith = true
			$Blacksmith/MinigameArea2D.monitoring = true
			$TreeAndRocks/TreeArea2D.monitoring = true
			if GlobalOptions.isPortuguese:
				$Player/Camera2D/CanvasLayer/Hint.sendHint("Use a forja e monte uma ferramenta que solucione o problema. Teste-a no tronco")
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'jose',
						'falas': [
							'Olá, o senhor é o ferreiro desta cidade?'
						]
					},
					{
						'personagem': 'blacksmith',
						'falas': [
							'E aí garoto, sim, sou o poderoso Horn, as minhas armas são forjadas com o puro fogo do dragão. O que você precisa?'
						]
					},
					{
						'personagem': 'jose',
						'falas': [
							'Estava precisando de um machado para cortar um tronco'
						]
					},
					{
						'personagem': 'blacksmith',
						'falas': [
							'O machado é composto por 3 partes: cabeça, cabo e cabeçote. Tenho 3 modelos para cada parte, cabe a você saber o que é melhor para o seu machado.',
							'Agora, entre na minha forja e escolha quais partes você quer'
						]
					},
				])
			else:
				$Player/Camera2D/CanvasLayer/Hint.sendHint("Use the forge and make the tool to solve the problem. Give it a try on the log")
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'jose',
						'falas': [
							'Excuse me sir, are you the city’s smith?'
						]
					},
					{
						'personagem': 'blacksmith',
						'falas': [
							"Hey boy, yes, I’m the almighty Horn! Me weapons are forged with the dragon's fire. What do ya need?"
						]
					},
					{
						'personagem': 'jose',
						'falas': [
							'I’m in need of an axe to cut a log.'
						]
					},
					{
						'personagem': 'blacksmith',
						'falas': [
							'The ax has 3 parts: head, yoke and handle. I have 3 models for each one of them, it is up to ya knowing which is the best.',
							'Now enter me forge and you may choose!'
						]
					},
				])
		else:
			if GlobalOptions.isPortuguese:
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'blacksmith',
						'falas': [
							'Raridade o rei estar aqui, o que será que ele precisa?'
						]
					}
				])
			else:
				$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'blacksmith',
						'falas': [
							"Unusual to see the king here, does he needs somethin'?"
						]
					}
				])

func _on_TreeArea2D_area_entered(area):
	if $TreeAndRocks/Treelog/TreelogSelected:
		enteredTreeArea = true
		$TreeAndRocks/Treelog/TreelogSelected.show()
	
func _on_TreeArea2D_area_exited(area):
	if $TreeAndRocks/Treelog/TreelogSelected:
		enteredTreeArea = false
		$TreeAndRocks/Treelog/TreelogSelected.hide()
		
	if !$Player/Camera2D/CanvasLayer/WeaponFrame.visible:
		$Player/Camera2D/CanvasLayer/WeaponFrame.show()

func _on_Lumberjack_area_entered(area):
	$Lumberjack.setState(1)
	enteredLumberjackArea = true

func _on_Lumberjack_area_exited(area):
	$Lumberjack.setState(0)
	enteredLumberjackArea = false
	$Player/Camera2D/CanvasLayer/WeaponFrame.show()

func _on_King_area_entered(area):
	$King.setState(1)
	enteredKingArea = true

func _on_King_area_exited(area):
	$King.setState(0)
	enteredKingArea = false
	$Player/Camera2D/CanvasLayer/WeaponFrame.show()

func _on_Blacksmith_area_entered(area):
	$Blacksmith.setState(1)
	enteredBlacksmithArea = true

func _on_Blacksmith_area_exited(area):
	$Blacksmith.setState(0)
	enteredBlacksmithArea = false
	$Player/Camera2D/CanvasLayer/WeaponFrame.show()

func _on_Marketer_area_entered(area):
	$Marketer.setState(1)
	enteredMarketerArea = true

func _on_Marketer_area_exited(area):
	$Marketer.setState(0)
	enteredMarketerArea = false
	$Player/Camera2D/CanvasLayer/WeaponFrame.show()

func _on_Area2D_area_entered(area):
	GlobalOptions.dimensoes["vision"] = true
	get_tree().change_scene("res://Cenas/Fases/Fase 2/Fase2.tscn")

# Função que prepara o ambiente depois que o jogador vence o minigame
func hitTheAxe():
	$Marketer.setInteraction(0)
	$Blacksmith.setInteraction(0)
	$Lumberjack.setInteraction(0)
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/Hint.sendHint("Use o machado para liberar o caminho")
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem': 'blacksmith',
				'falas': [
					'Acho que esse é o melhor para o serviço. Boa sorte!'
				]
			}
		])
	else:
		$Player/Camera2D/CanvasLayer/Hint.sendHint("Use the axe to clear the way")
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem': 'blacksmith',
				'falas': [
					'I think this one will do for the job. Good luck!'
				]
			}
		])
	$Player/Camera2D/CanvasLayer/WeaponFrame.hide()
	
		
func showAxeFrame():
	$Player/Camera2D/CanvasLayer/WeaponFrame/PunchIcon.hide()
	$Player/Camera2D/CanvasLayer/WeaponFrame/Machado.setSprites(
		GlobalFase1.axeChoicedParts[0]['sprite'], # Cabo
		GlobalFase1.axeChoicedParts[1]['sprite'], # Lamina
		GlobalFase1.axeChoicedParts[2]['sprite'] # Cabecote
	)
	$Player/Camera2D/CanvasLayer/WeaponFrame/Machado.show()
	$Player/Camera2D/CanvasLayer/WeaponFrame.show()

func _on_MinigameArea2D_area_exited(area):
	$Player/Camera2D/CanvasLayer/Hint.show()
	showAxeFrame()
	
	if(GlobalFase1.AxeOk):
		$Blacksmith/MinigameArea2D.visible = false
		$Blacksmith/MinigameArea2D.monitoring = false
		
	

# Função que executa a chamada do minigame da fase 1
func _on_MinigameArea2D_area_entered(area):
	$Player/Camera2D/CanvasLayer/Hint.hide()
	$Player/Camera2D/CanvasLayer/WeaponFrame.hide()
	$Player.setWeapon(1)
	GlobalFase1.axeChoicedParts = []
	get_tree().paused = true
	$Player/Camera2D/CanvasLayer/PopupMinigame.show()
	$Player/Camera2D/CanvasLayer/PopupMinigame/Control.show()
	$Player.setMoveDirection(Vector2(0,0))
	
# Setup da fase
func _ready():
	$Player/Camera2D/CanvasLayer/PopupMinigame.hide()
	$TreeAndRocks/TreeArea2D.monitoring = false
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/Hint.sendHint("Fale com os residentes da vila")
	else:
		$Player/Camera2D/CanvasLayer/Hint.sendHint("Talk to the villagers")
		$Player/Camera2D/CanvasLayer/DimensionFrame/Label.text = 'Vision'
	$Player/Camera2D/CanvasLayer/Hint.visible = true
	
	$Marketer.setInteraction(1)
	$Player.setTerrain(0)
	$VillageSound.play()


func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		if enteredMarketerArea:
			$Player/Camera2D/CanvasLayer/WeaponFrame.hide()
			sendMarketerDialog()
		elif enteredKingArea:
			$Player/Camera2D/CanvasLayer/WeaponFrame.hide()
			sendKingDialog()
		elif enteredLumberjackArea:
			$Player/Camera2D/CanvasLayer/WeaponFrame.hide()
			sendLumberjackDialog()
		elif enteredBlacksmithArea:
			$Player/Camera2D/CanvasLayer/WeaponFrame.hide()
			sendBlacksmithDialog()
			
	verifyAndRemoveTree()
		
# Função que verifica se o usuário concluiu o minigame e pode cortar o tronco caído
func _process(delta):
	GlobalFase2.paralax($Player,$Lumberjack)
	GlobalFase2.paralax($Player,$Blacksmith)
	GlobalFase2.paralax($Player,$Marketer)
	GlobalFase2.paralax($Player,$King)
	
	if(!endGameSetedUp && GlobalFase1.AxeOk):
		hitTheAxe()
		endGameSetedUp = true
		
