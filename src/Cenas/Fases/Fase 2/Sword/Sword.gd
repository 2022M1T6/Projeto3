extends StaticBody2D

enum STATES {IDLE, IDLE_ACTION} # Estado atual do NPC

export (int) var state = STATES.IDLE

# Função que seta o estado do personagem
func setState(newState: int):
	state = newState
	animate()

# Função que executa a animação do personagem
func animate():
	match state:
		STATES.IDLE:
			$Sprite.texture = load("res://Public/Items/swordOfRoadmapBuried.png")
			$actionButton.visible = false
		STATES.IDLE_ACTION:
			$Sprite.texture = load("res://Public/Items/swordOfRoadmapBuriedAction.png")
			$actionButton.visible = true
