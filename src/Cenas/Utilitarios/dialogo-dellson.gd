extends PopupDialog

onready var dialogBoxLabel = $DialogBox/Label
var podeIrParaProximaLinha = false
var completarFrase = false
# Essa variável determina se é a primeira vez que o player vê determinada fala
var primeiraVez = 0
var fase1Dialog = [false,false,false,false]

var dialogos = []
var dialogoAtual = {"personagem": "", "falas": []}

# Função que estabelece qual sprite usar quando estiver na fala
func getDialogSpriteFilePath():
	if dialogoAtual["personagem"] == 'dellson':
		return "res://Public/Characters/dellsonProfile.png"
	elif dialogoAtual["personagem"] == 'jose':
		return "res://Public/Characters/playerProfile.png"
	elif dialogoAtual["personagem"] == 'blacksmith':
		return "res://Public/Characters/blacksmithProfile.png"
	elif dialogoAtual["personagem"] == 'king':
		return "res://Public/Characters/kingProfile.png"
	elif dialogoAtual["personagem"] == 'lumberjack':
		return "res://Public/Characters/lumberjackProfile.png"
	elif dialogoAtual["personagem"] == 'marketer':
		return "res://Public/Characters/marketerProfile.png"
	else:
		return "res://Public/Characters/fabiProfile.png"
		
# Função que mostra a próxima mensagem do array de diálogos
func mostrarMensagem() -> void:
	if dialogoAtual["falas"].size() == 0 && dialogos.size() == 0:
		get_tree().paused = false
		hide()
		return
	
	if(dialogoAtual["falas"].size() == 0):
		dialogoAtual = dialogos.pop_front()
	
	var text = dialogoAtual["falas"].pop_front()	
	dialogBoxLabel.percent_visible = 0
	dialogBoxLabel.text = text
	podeIrParaProximaLinha = false

	# Verifica se a foto da caixa de diálogo está condizente com o personagem e troca caso necessário
	$DialogSprite.texture = load(getDialogSpriteFilePath())

	show()
	return
	
# Neste caso, esta função serve para que ao pressionar o botão E, a fala mude para a próxima
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if(podeIrParaProximaLinha):
			mostrarMensagem()
		else:
			completarFrase = true

func _on_Timer_timeout():
	if(dialogBoxLabel.percent_visible >= 1):
		podeIrParaProximaLinha = true
	else:
		if completarFrase:
			dialogBoxLabel.percent_visible = 1
			podeIrParaProximaLinha = true
			completarFrase = false
		else:
			var percentVisible = 0.01
			if(len(dialogBoxLabel.text) < 30):
				percentVisible = 0.03
			elif len(dialogBoxLabel.text) >= 30 && len(dialogBoxLabel.text) <= 60:
				percentVisible = 0.02
				
			dialogBoxLabel.percent_visible += percentVisible


# A partir daqui, cada função determina qual fala o jogo deve dar display ao atravessar certos pontos de interesse


func _on_TutoraiMapa1Fala1_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if primeiraVez == 0:
		dialogos = [
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
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1
	



func _on_TutoraiMapa1Fala2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if primeiraVez == 1:
		dialogos = [
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
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1


func _on_TutorialMapa2Fala1_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if primeiraVez == 0:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas': [
					'Eu fiquei com preguiça de terminar essa área, então fiz o upload de um mapa da Internet mesmo. Espero que você não fique assustado…',
					'hehe'
				]
			},
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez +=1


func _on_TuroailMapa2Fala2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if primeiraVez == 1:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas': [
					'BOO!!',
					'Errei o timing?',
					'… Enfim, quando você se deparar com um lugar o qual não consegue passar, pressione ESPAÇO para atravessar pequenos obstáculos.'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1


func _on_Area2D2_area_entered(area):
	if primeiraVez == 0:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas':[
					'Você estava esperando alguma coisa? Eu achei que já tinha te dado um susto.',
					'De qualquer forma, caso você encontre inimigos, presione P para atacá-los.',
					'Aqui está um boneco para você treinar!',
					'Quando conseguir derrotá-lo, posso considerar que você que você já aprendeu o básico e consegue se virar sem mim.',
					'Assim eu posso voltar para meu modo de hibernação.',
					'...',
					'Agora venha aqui e destrua esse boneco!'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1


func _on_Hurtbox_area_entered(area):
	if primeiraVez == 1:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas':[
					'ISSO, ACABA COM ELE!!',
					'Ahem... Quando você derrotá-lo, eu irei abrir esse portão a direita, ele te levará ao mundo externo'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez +=1
		

func _on_Area2D3_area_entered(area):
	if primeiraVez == 2:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas':[
					'ESPERA!!!',
					'Eu sei que você já aprendeu o básico, mas com o meu intelecto e seu ... corpo(?), eu acho que chegaremos muito mais longe e você aprenderá muito mais.',
					'O que você acha, parceiro?'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1


func _on_Area2D4_area_entered(area):
	if primeiraVez == 3:
		dialogos = [
			{
				'personagem': 'dellson',
				'falas':[
					'Não precisa responder, vou entrar na sua mochila!',
					'Com licença.'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
		primeiraVez += 1


func _on_Marketer_area_entered(area):
		if fase1Dialog[0] == false:
			dialogos = [
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
			]
			mostrarMensagem()
			get_tree().paused = true
			fase1Dialog[0] = true
		else:
			dialogos = [
				{
					'personagem':'marketer',
					'falas':[
						'Lembre-se, entender o problema é a parte mais importante para resolvê-lo'
					]
				}
			]
			mostrarMensagem()
			get_tree().paused = true


func _on_King_area_entered(area):
		if fase1Dialog[1] == false:
			dialogos = [
				{
					'personagem': 'jose',
					'falas': [
						'Ei cara, tudo bem? PArece que você viu um fantasma'
					]
				},
				{
					'personagem': 'king',
					'falas': [
						'CARA????? SOU O REI GINALDO SEGUNDO',
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
			]
			mostrarMensagem()
			get_tree().paused = true
			fase1Dialog[1] = true
			GlobalFase1.kingTalk = true
		else:
			dialogos = [
				{
					'personagem':'king',
					'falas':[
						'Como está o progresso? Eu quero cortar logo essas árvores e voltar para o meu castelo'
					]
				}
			]
			mostrarMensagem()
			get_tree().paused = true





func _on_Lumberjack_area_entered(area):
	if fase1Dialog[2] == false and fase1Dialog[1] == true:
		dialogos = [
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
		]
		mostrarMensagem()
		get_tree().paused = true
		fase1Dialog[2] = true
		GlobalFase1.kingTalk = true
		
	elif fase1Dialog[2] == false and fase1Dialog[1] == false:
		dialogos = [
			{
				'personagem': 'lumberjack',
				'falas': [
					'O rei parece estar com problemas, você pode ir falar com ele?'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
	else:
		dialogos = [
			{
				'personagem': 'lumberjack',
				'falas': [
					'Lembre-se, muitas vezes a ferramenta mais simples é a ideal para o problema'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true


func _on_Blacksmith_area_entered(area):
	if fase1Dialog[3] == false and fase1Dialog[1] == true:
		dialogos = [
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
		]
		mostrarMensagem()
		get_tree().paused = true
		fase1Dialog[3] = true
		GlobalFase1.blacksmithTalk = true
	elif fase1Dialog[3] == false and fase1Dialog[1] == false:
		dialogos = [
			{
				'personagem': 'blacksmith',
				'falas': [
					'Raridade o rei estar aqui, o que será que ele precisa?'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
	else:
		dialogos = [
			{
				'personagem': 'blacksmith',
				'falas': [
					'Você precisa de algo? Pode entrar na minha forja'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true

func _on_MinigameArea2D_area_exited(area):
	if GlobalFase1.AxeOk == true:
		dialogos = [
			{
				'personagem': 'blacksmith',
				'falas': [
					'Acho que esse é o melhor para o serviço, boa sorte!'
				]
			}
		]
		mostrarMensagem()
		get_tree().paused = true
