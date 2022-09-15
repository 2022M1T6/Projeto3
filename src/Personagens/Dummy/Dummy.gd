extends KinematicBody2D

enum STATES {IDLE} # Estado atual do NPC
enum INTERACTIONS {NONE, MISSION, DIALOG} # Balão de fala do jogador

var state = STATES.IDLE
var interaction = INTERACTIONS.NONE

var maxHp = 60
var currentHp = 60

# Função que seta o estado do personagem
func setState(newState: int):
	state = newState

# Função que mata o personagem
func die():
	queue_free()
	
func showHp():
	$HP.text = currentHp

# Função que redefine a vida atual do personagem
func setCurrentHp(newHp: float):
	if newHp <= 0:
		die()
		return
	
	if newHp > maxHp:
		currentHp = maxHp
	
	showHp()

# Função que simula um dano levado pelo personagem
func takeDamage(damage):
	setCurrentHp(currentHp - damage)
	return currentHp
	
# Função que seta se o personagem deve mostrar o balão de missão
func setInteraction(newInteraction: int):
	interaction = newInteraction
	setUpBubbles()

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


func _on_Area2D_area_entered(area):
	print("I got hit")
