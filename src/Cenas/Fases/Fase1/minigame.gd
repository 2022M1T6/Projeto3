extends Control

# Pré-carregamento da cena que contém o card
var cardScene = preload("res://Cenas/Fases/Fase1/Card.tscn")

# Variável que guarda qual é posição atual da matriz
var actualIndex = 0

# Função que instancia um novo card na tela e muda seus elementos conforme o array global
func instanceCard(cardInfo):
	var newCard = cardScene.instance()
	newCard.get_node("titulo").text = cardInfo['titulo']
	newCard.get_node("Sprite").texture = load(cardInfo['sprite'])
	newCard.get_node("descricao").text = cardInfo['descricao']
	newCard.set_position(cardInfo['position'])
	
	newCard.connect("pressed", self, "_onMinigameCardPressed", [cardInfo['titulo']])
	
	return newCard

# Função que retira os cards que estão impressos na tela
func removeCards():
	for categoria in GlobalFase1.cards:
		for carta in categoria:
			if carta["objeto"] && carta["objeto"] != null:
				carta["objeto"].queue_free()
				carta["objeto"] = false

# Função que imprime na tela os cards que estão na posição atual da matriz
func setCards():
	removeCards()
	for i in range(len(GlobalFase1.cards[actualIndex])):
		var newCard = instanceCard(GlobalFase1.cards[actualIndex][i])
		GlobalFase1.cards[actualIndex][i]['objeto'] = newCard
		$Control/ColorRect/Cards.add_child(newCard)

# Função que filtra os cards e retorna o card com o titulo desejado
func getCardByTitulo(titulo):
	for i in range(len(GlobalFase1.cards[actualIndex])):
		if titulo == GlobalFase1.cards[actualIndex][i]['titulo']:
			return GlobalFase1.cards[actualIndex][i]

# Verifica se o machado montado até o momento é o machado certo
func verifyActualAxeOk():
	var actualAxeOk = true
	for i in range(len(GlobalFase1.choicedCards)):
		if len(GlobalFase1.choicedCards) == 3:
			if !GlobalFase1.choicedCards[i]['correto']:
				actualAxeOk = false
		else:
			actualAxeOk = false
	GlobalFase1.AxeOk = actualAxeOk

# Função que monta um machado com as peças que foram selecionadas dentro do minigame
func montarMachado():
	var actualAxeOk = true
	for i in range(len(GlobalFase1.choicedCards)):
		verifyActualAxeOk()
		var textureRect = $Control/ColorRect/Machado/Cabo
		var textureRectMachadoGrande = $Control/ColorRect/MachadoGrande/Cabo
		if i == 1:
			textureRect = $Control/ColorRect/Machado/Lamina
			textureRectMachadoGrande = $Control/ColorRect/MachadoGrande/Lamina
		elif i == 2:
			textureRect = $Control/ColorRect/Machado/Cabecote
			textureRectMachadoGrande = $Control/ColorRect/MachadoGrande/Cabecote
		textureRect.texture = load(GlobalFase1.choicedCards[i]['sprite'])
		textureRectMachadoGrande.texture = load(GlobalFase1.choicedCards[i]['sprite'])		
		
# Função que prepara o minigame nas configurações iniciais
func redefinirMinigame():
	actualIndex = 0
	setCards()
	GlobalFase1.choicedCards = []
	hide()
	get_tree().paused = false
	$Control/ColorRect/Machado/Cabo.texture = null
	$Control/ColorRect/Machado/Lamina.texture = null
	$Control/ColorRect/Machado/Cabecote.texture = null
	
	$Control/ColorRect/Machado.visible = true
	$Control/ColorRect/MachadoGrande.visible = false
	$Control/ColorRect/Button.visible = false
	
func sendMinigame():
	GlobalFase1.axeChoicedParts = []
	get_tree().paused = true
	show()
	
# Função que recebe o evento de click nos cards. Salva as alterações e prepara para uma próxima execução	
func _onMinigameCardPressed(titulo):
	var card = getCardByTitulo(titulo)
	GlobalFase1.choicedCards.append(card)
	actualIndex += 1
	montarMachado()
	
	if actualIndex >= len(GlobalFase1.cards):
		GlobalFase1.axeChoicedParts = GlobalFase1.choicedCards
		removeCards()
		$Control/ColorRect/Machado.visible = false
		$Control/ColorRect/MachadoGrande.visible = true
		$Control/ColorRect/Button.visible = true
	else:
		setCards()

# Prepara o ambiente do minigame para a primeira execução
func _ready():
	redefinirMinigame()

# Função que recebe o click do botão forjar. Redefine o game para uma próxima jogada
func _on_Button_pressed():
	if len(GlobalFase1.axeChoicedParts) == 3:
		redefinirMinigame()
