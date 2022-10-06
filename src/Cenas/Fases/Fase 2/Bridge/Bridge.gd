extends StaticBody2D

enum STATES {HIDDEN, ACTION, CONSTRUCTED}
var state = STATES.HIDDEN
export (int) var woodCost = 1

func rotateActionButton():
	$ActionButton.rotation_degrees = -round(rotation_degrees)

# Função que seta a sprite da árvore de acordo com o state
func setSpriteByState():
	match state:
		STATES.HIDDEN:
			$Sprite.visible = false
			$ActionButton.visible = false
		STATES.ACTION:
			$Sprite.visible = true
			$Sprite.self_modulate = "55ffffff"
			rotateActionButton()
			$ActionButton.visible = true
		STATES.CONSTRUCTED:
			$Sprite.visible = true
			$Sprite.self_modulate = "ffffff"
			$ActionButton.visible = false
			
# Função que seta o state da árvore	
func setState(newState):
	if state != STATES.CONSTRUCTED:
		state = newState
		setSpriteByState()
	
# Mostra o sprite de ponte construida e remove o collision e area2d de ação
func constructBridge():
	$Block.queue_free()
	$Input.queue_free()
	GlobalFase2.wood -= woodCost
	
	setState(STATES.CONSTRUCTED)

#Função para quando o jogador entra na área input
func _on_Input_area_entered(area):
	setState(STATES.ACTION)

#Função para quando o jogador sai da área input
func _on_Input_area_exited(area):
	setState(STATES.HIDDEN)
	
# Função que capta os eventos do teclado do usuário
func _unhandled_key_input(event):
	# Se o botão de ataque for apertado enquanto o player estiver dentro da área da ponte e o player possuir a quantidade de madeira necessária para construí-la, constrói a ponte
	if Input.is_action_just_pressed("interact") && state == STATES.ACTION && GlobalFase2.wood >= woodCost:
		constructBridge()
		
	return event
		
func _ready():
	setState(STATES.HIDDEN)
	$ActionButton/WoodCountFrame/WoodCountLabel.text = ' x ' + str(woodCost)



