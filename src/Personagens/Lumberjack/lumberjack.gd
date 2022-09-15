extends KinematicBody2D

enum STATES {IDLE, IDLE_ACTION} # Estado atual do NPC
enum INTERACTIONS {NONE, MISSION, DIALOG} # Balão de fala do jogador

export (int) var state = STATES.IDLE
export (int) var interaction = INTERACTIONS.NONE

# Função que seta o estado do personagem
func setState(newState: int):
	state = newState

# Função que seta se o personagem deve mostrar o balão de missão
func setInteraction(newInteraction: int):
	interaction = newInteraction
	setUpBubbles()


# Função que executa a animação do personagem
func animate():
	match state:
		STATES.IDLE:
			$AnimationPlayer.play("idle")
			$actionButton.visible = false
		STATES.IDLE_ACTION:
			$AnimationPlayer.play("actionIdle")
			$actionButton.visible = true
		

# Função que mostra ou esconde os balões de ação do personagem
func setUpBubbles():
	match interaction:
		INTERACTIONS.DIALOG:
			$missionBubble.visible = false
			$dialogBubble.visible = true
		INTERACTIONS.MISSION:
			$missionBubble.visible = true
			$dialogBubble.visible = false
		INTERACTIONS.NONE:
			$missionBubble.visible = false
			$dialogBubble.visible = false
	
func _process(delta):
	animate()
