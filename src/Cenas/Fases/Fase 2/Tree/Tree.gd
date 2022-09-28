extends StaticBody2D

enum STATES {IDLE, ACTION, CUT}
var state = STATES.IDLE
export (int) var wood = 2

# Função que remove o objeto árvore e adiciona madeira a variável global da fase
func cut():
	if state != STATES.CUT:
		queue_free()
		GlobalFase2.wood += wood
		setState(STATES.CUT)
		
# Função que seta a sprite da árvore de acordo com o state
func setSpriteByState():
	match state:
		STATES.IDLE:
			$Sprite.texture = load("res://Public/Scenery/Tree/tree.png")
			$ActionButton.visible = false
		STATES.ACTION:
			$Sprite.texture = load("res://Public/Scenery/Tree/actionTree.png")
			$ActionButton.visible = true
		
# Função que seta o state da árvore	
func setState(newState):
	state = newState
	setSpriteByState()
	
# Função que altera o state da árvore quando algo entra em sua zona de ação
func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	setState(STATES.ACTION)

# Função que altera o state da árvore quando algo sai de sua zona de ação
func _on_Area2D_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
		setState(STATES.IDLE)

# Função que capta os eventos do teclado do usuário
func _unhandled_key_input(event):
	# Se o botão de ataque for apertado enquanto o player estiver dentro da área da árvore, vai corta-la
	if Input.is_action_just_pressed("attack") && state == STATES.ACTION:
		cut()

func _ready():
	setState(STATES.IDLE)
