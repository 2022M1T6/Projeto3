extends Node2D

var enteredTreeArea = false
var enteredBlacksmithArea = false
var enteredLumberjackArea = false
var enteredKingArea = false
var enteredMarketerArea = false

var fase1Dialog = {"marketer": false, "king": false, "lumberjack": false, "blacksmith": false}

# Setup da fase
func _ready():
	$Jose/Camera2D/CanvasLayer/PopupMinigame.hide()
	$TreeAndRocks/TreeArea2D.monitoring = false
	
	$Jose/Camera2D/CanvasLayer/Hint/HintText.text = "Fale com os NPCs"
	$Jose/Camera2D/CanvasLayer/Hint.visible = true
	
	$Marketer.call("setInteraction", 1)
	$VillageSound.play()

# Função que executa a chamada do minigame da fase 1
func _on_Area2D2_area_entered(area):
	GlobalFase1.axeChoicedParts = []
	get_tree().paused = true
	$Jose/Camera2D/CanvasLayer/PopupMinigame.show()
	$Jose/Camera2D/CanvasLayer/PopupMinigame/Control.show()

# Função que verifica se o usuário concluiu o minigame e pode cortar o tronco caído
func _process(delta):
	if(GlobalFase1.AxeOk):
		$Blacksmith/MinigameArea2D.visible = false
		$Blacksmith/MinigameArea2D.monitoring = false
		
		$TreeAndRocks/TreeArea2D.monitoring = true

# Função que verifica se o tronco caído pode ser retirado
func verifyAndRemoveTree():
	if Input.is_action_just_pressed("punch") && enteredTreeArea && GlobalFase1.AxeOk:
		$TreeAndRocks/Treelog.queue_free()

# Faz o envio dos diálogos do marketer
func sendMarketerDialog():
	if fase1Dialog.marketer:
		$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [
				{
					'personagem':'marketer',
					'falas':[
						'Lembre-se, entender o problema é a parte mais importante para resolvê-lo'
					]
				}
		])
		$Marketer.call("setInteraction", 0)
	else:
		fase1Dialog.marketer = true # Marca que o jogador já falou com o Marketer
		$Marketer.call("setInteraction", 0) # Muda a interação do marketer para sem balão
		$King.call("setInteraction", 1)
		$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [ # Envia o diálogo do marketer
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
		$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [
			{
				'personagem':'king',
				'falas':[
					'Como está o progresso? Eu quero cortar logo essas árvores e voltar para o meu castelo'
				]
			}
		])
	else:
		fase1Dialog.king = true
		$King.call("setInteraction", 0) # Tira o balão do king
		$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [ # Envia o diálogo com king
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
		$Marketer.call("setInteraction", 0) # Seta a interação para sem balões para o marketer		
		$Blacksmith.call("setInteraction", 1) # Seta o balão de missão para o blacksmith
		$Lumberjack.call("setInteraction", 2) # Seta o balão de diálogo para o lumberjack
		
# Faz o envio dos diálogos do lumberjack
func sendLumberjackDialog():
	if fase1Dialog.lumberjack:
		if fase1Dialog.king:
			$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [
				{
					'personagem': 'lumberjack',
					'falas': [
						'Lembre-se, muitas vezes a ferramenta mais simples é a ideal para o problema'
					]
				}
			])
		else:
			$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [
				{
					'personagem': 'lumberjack',
					'falas': [
						'O rei parece estar com problemas, você pode ir falar com ele?'
					]
				}
			])
	else:
		fase1Dialog.lumberjack = true
		$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [
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
		
# Faz o envio dos diálogos do blacksmith
func sendBlacksmithDialog():
	if fase1Dialog.blacksmith:
		$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [
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
			$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [
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
			$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [
				{
					'personagem': 'blacksmith',
					'falas': [
						'Raridade o rei estar aqui, o que será que ele precisa?'
					]
				}
			])

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		if enteredMarketerArea:
			sendMarketerDialog()
		elif enteredKingArea:
			sendKingDialog()
		elif enteredLumberjackArea:
			sendLumberjackDialog()
		elif enteredBlacksmithArea:
			sendBlacksmithDialog()
			
	verifyAndRemoveTree()
		
func _on_TreeArea2D_area_entered(area):
	enteredTreeArea = true
	
func _on_TreeArea2D_area_exited(area):
	enteredTreeArea = false

func _on_Lumberjack_area_entered(area):
	$Lumberjack.call("setState", 1)
	enteredLumberjackArea = true

func _on_Lumberjack_area_exited(area):
	$Lumberjack.call("setState", 0)
	enteredLumberjackArea = false

func _on_King_area_entered(area):
	$King.call("setState", 1)
	enteredKingArea = true

func _on_King_area_exited(area):
	$King.call("setState", 0)
	enteredKingArea = false

func _on_Blacksmith_area_entered(area):
	$Blacksmith.call("setState", 1)
	enteredBlacksmithArea = true

func _on_Blacksmith_area_exited(area):
	$Blacksmith.call("setState", 0)
	enteredBlacksmithArea = false

func _on_Marketer_area_entered(area):
	$Marketer.call("setState", 1)
	enteredMarketerArea = true

func _on_Marketer_area_exited(area):
	$Marketer.call("setState", 0)
	enteredMarketerArea = false

func _on_Area2D_area_entered(area):
	get_tree().change_scene("res://Cenas/Utilitarios/FimDemo.tscn")


func _on_MinigameArea2D_area_exited(area):
	if GlobalFase1.AxeOk:
		$Marketer.call("setInteraction", 0)
		$Blacksmith.call("setInteraction", 0)
		$Lumberjack.call("setInteraction", 0)
		
		$Jose/Camera2D/CanvasLayer/PopupDialog.call("sendDialog", [
			{
				'personagem': 'blacksmith',
				'falas': [
					'Acho que esse é o melhor para o serviço, boa sorte!'
				]
			}
		])
