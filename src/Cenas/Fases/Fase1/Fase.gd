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
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas': [
						'Hmm... Parece que esse machado não vai funcionar tão bem. Tente colher informações com os residentes e montar outro machado na casa do ferreiro!'
					]
				}
			])

# Faz o envio dos diálogos do marketer
func sendMarketerDialog():
	if fase1Dialog.marketer:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem':'marketer',
					'falas':[
						'Lembre-se, entender o problema é a parte mais importante para resolvê-lo'
					]
				}
		])
		$Marketer.setInteraction(0)
	else:
		fase1Dialog.marketer = true # Marca que o jogador já falou com o Marketer
		$Marketer.setInteraction(0) # Muda a interação do marketer para sem balão
		if !fase1Dialog.king:
			$King.setInteraction(1)
			$Player/Camera2D/CanvasLayer/Hint.sendHint("Verifique se o rei está com problemas")
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([ # Envia o diálogo do marketer
				{
					'personagem': 'marketer',
					'falas': [
						'Aaaaaah meu jovem, como eu queria ter essa idade, com a visão que tenho hoje eu poderia ter entendido muitas coisas em minha vida.',
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
						'Tenho um segredo que é tentar compreender os problemas das pessoas e passar a visão do que poderia ser feito, e assim eles se tornam meus clientes e compram muita comida HAHAHA!!',
						'Quer comprar uma maça? Elas recuperam a fadiga'
					]
				}
		])
		
# Faz o envio dos diálogos do king
func sendKingDialog():
	if fase1Dialog.king:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem':'king',
				'falas':[
					'Como está o progresso? Eu quero cortar logo essas árvores e voltar para o meu castelo'
				]
			}
		])
	else:
		fase1Dialog.king = true
		$King.setInteraction(0) # Tira o balão do king
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
					'CARA????? COMO OUSA? SOU O REI GINALDO SEGUNDO',
					'Um fantasma não, mas suponho que seja alguma bruxaria! Essas árvores apareceram do nada.'
				]
			},
			{
				'personagem': 'dellson',
				'falas': [
					'(cochicho) Ops, acredito que eu renderizei sem querer…, vamos ajudar esse cara, fiquei com peso na consciência.'
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
					'Bom, precisamos dar um jeito de tirar essas árvores do nosso caminho'
				]
			},
			{
				'personagem':'jose',
				'falas':[
					'...',
					'Tá bom, vamos pensar em algo'
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
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'lumberjack',
					'falas': [
						'Lembre-se, muitas vezes a ferramenta mais simples é a ideal para o problema'
					]
				}
			])
		else:
			fase1Dialog.lumberjack = true
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
						'Aaaah, mas ainda não entendi o porquê de bater as mãos na árvore. E que legal, então quer dizer que você é amigo do Dellson!?'
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
						'Se você colorir uma faca, a funcinalidade é a mesma. Portanto, gaste tempo pensando no que faz um machado bom para cortar árvores'
					]
				}
			])
	else:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem': 'lumberjack',
				'falas': [
					'O rei parece estar com problemas, você pode ir falar com ele?'
				]
			}
		])
		
# Faz o envio dos diálogos do blacksmith
func sendBlacksmithDialog():
	if fase1Dialog.blacksmith:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem': 'blacksmith',
				'falas': [
					'Você precisa de algo? Pode entrar na minha forja'
				]
			}
		])
	else:
		if fase1Dialog.king:
			fase1Dialog.blacksmith = true
			$Blacksmith/MinigameArea2D.monitoring = true
			$TreeAndRocks/TreeArea2D.monitoring = true
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
						'Estava precisando de um machado para cortar árvores'
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
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'blacksmith',
					'falas': [
						'Raridade o rei estar aqui, o que será que ele precisa?'
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
	get_tree().change_scene("res://Cenas/Utilitarios/FimDemo.tscn")

# Função que prepara o ambiente depois que o jogador vence o minigame
func hitTheAxe():
	$Marketer.setInteraction(0)
	$Blacksmith.setInteraction(0)
	$Lumberjack.setInteraction(0)
	$Player/Camera2D/CanvasLayer/Hint.sendHint("Use o machado para liberar o caminho")
	
	$Player/Camera2D/CanvasLayer/WeaponFrame.hide()
	$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				'personagem': 'blacksmith',
				'falas': [
					'Acho que esse é o melhor para o serviço, boa sorte!'
				]
			}
		])
		
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
	
	$Player/Camera2D/CanvasLayer/Hint.sendHint("Fale com os residentes da vila")
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
		
