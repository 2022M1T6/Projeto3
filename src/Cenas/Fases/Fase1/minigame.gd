extends Control
var cardScene = preload("res://Cenas/Fases/Fase1/Card.tscn")

var actualIndex = 0

func instanceCard(cardInfo):
	var newCard = cardScene.instance()
	newCard.get_node("titulo").text = cardInfo['titulo']
	newCard.get_node("Sprite").texture = load(cardInfo['sprite'])
	newCard.get_node("descricao").text = cardInfo['descricao']
	newCard.set_position(cardInfo['position'])
	
	newCard.connect("pressed", self, "_onMinigameCardPressed", [cardInfo['titulo']])
	
	return newCard
	
func setCards():
	for i in range(len(GlobalFase1.cards)):
		for n in range(len(GlobalFase1.cards[i])):
			if GlobalFase1.cards[i][n]['objeto']:
				GlobalFase1.cards[i][n]['objeto'].queue_free()
				GlobalFase1.cards[i][n]['objeto'] = false
	
	for i in range(len(GlobalFase1.cards[actualIndex])):
		var newCard = instanceCard(GlobalFase1.cards[actualIndex][i])
		GlobalFase1.cards[actualIndex][i]['objeto'] = newCard
		$Control/ColorRect/Cards.add_child(newCard)

func getCardByTitulo(titulo):
	for i in range(len(GlobalFase1.cards[actualIndex])):
		if titulo == GlobalFase1.cards[actualIndex][i]['titulo']:
			return GlobalFase1.cards[actualIndex][i]

func on_buttonClick(titulo):
	var card = getCardByTitulo(titulo)
	GlobalFase1.choicedCards.append(card)
	actualIndex += 1
	
	if actualIndex >= len(GlobalFase1.cards):
		print(GlobalFase1.choicedCards)
		hide()
		actualIndex = 0
		get_tree().paused = false
	else:
		setCards()
	
func _ready():
	setCards()
	
func _onMinigameCardPressed(binds):
	on_buttonClick(binds[0])
