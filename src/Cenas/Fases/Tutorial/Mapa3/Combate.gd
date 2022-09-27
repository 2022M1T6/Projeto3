extends Node2D
# Seta os valores do Dummy
onready var HP = $KinematicBody2D/Label
var currentHP = 60
var maxHP = 60
var dano = 20

# Prepara o audio do game e dispara o primeiro diálogo
func _ready():
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas':[
						'Você estava esperando alguma coisa? Eu achei que já tinha te dado um susto.',
						'De qualquer forma, caso você encontre inimigos, presione P para atacá-los.',
						'Aqui está um boneco para você treinar!',
						'Quando conseguir derrotá-lo, posso considerar que você já aprendeu o básico e consegue se virar sozinho.',
						'Assim posso voltar ao modo hibernação.',
						'...',
						'Agora vá e destrua o boneco!'
					]
				}
		])
	else:
		$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas':[
						'Were you expecting something? I thought I had already scared you.',
						'Anyways, if you come across an enemy, press P to attack ‘em.',
						'Here is a dummy… use it as a punching bag.',
						'When you beat him, I will consider you’ve already learned the basics and I’ll hibernate again',
						'...',
						'Now, destroy that dummy!'
					]
				}
		])

# Executado quando o player ataca o Dummy
func _on_Hurtbox_area_entered(area):
	# Diminui a vida do Dummy
	currentHP -= dano
	HP.text = str(currentHP)
	
	# Mata o Dummy se a vida for menor ou igual a 0 
	if currentHP <= 0:
		$Area2D.monitoring = true
		$Area2D3.monitoring = true
		currentHP = 0
		$KinematicBody2D.queue_free()
	
	# Na primeira vez que o dummy receber dano, dispara a fala do Dellson
	if maxHP - dano == currentHP:
		if GlobalOptions.isPortuguese:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas':[
						'ISSO, ACABA COM ELE!!',
						'Ahem... Quando você derrotá-lo, eu irei abrir esse portão a direita, ele te levará ao mundo externo'
					]
				}
			])
		else:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
				{
					'personagem': 'dellson',
					'falas':[
						'YES, ANNIHILATE HIM!!',
						"(Coff) ... When you beat him, I'll open that gate. It'll take you outside."
					]
				}
			])
			
		$Area2D3.monitoring = true
	
# Teletransporta o player para a primeira fase
func _on_Area2D_area_entered(area):
	if currentHP <= 0:
		get_tree().change_scene("res://Cenas/Transições/Transition1.tscn")
		

# Ao sair da primeira área, seta a hint
func _on_Area2D2_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/Hint.sendHint('Destrua o boneco de testes usando P e vá até a porta escura')
	else:
		$Player/Camera2D/CanvasLayer/Hint.sendHint('Beat the dummy using P and cross the gate')
	
# Ao chegar próximo da porta para o próximo nível, dispara o diálogo
func _on_Area2D3_area_entered(area):
	$Dellson/Sprite.flip_h = true
	if currentHP <= 0:	
		if GlobalOptions.isPortuguese:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'dellson',
						'falas':[
							'ESPERA!!!',
							'Eu sei que você já aprendeu o básico, mas com o meu intelecto e seu ... corpo(?), eu acho que chegaremos muito mais longe e você aprenderá muito mais.',
							'O que você acha, parceiro?',
							'Não precisa responder, vou entrar na sua mochila!',
							'Com licença.'
						]
					},
			])
		else:
			$Player/Camera2D/CanvasLayer/PopupDialog.sendDialog([
					{
						'personagem': 'dellson',
						'falas':[
							'WAIT!!!',
							"I know you've already learned the basics, but with my great intelligence and your… body(?) I think we can go much further and you'll learn way more.",
							'What do you think, partner?',
							'There’s no need to answer. I’ll get inside your bag.',
							'Excuse me'
						]
					},
			])

# Verifica se o Dummy morreu e some com o Dellson
func _on_Area2D3_area_exited(area):
	if currentHP <= 0:
		$Area2D3.queue_free()
		$Dellson.queue_free()

# Mostra a tecla de ataque ao chegar perto do Dummy
func _on_actionArea_area_entered(area):
	$KinematicBody2D/TeclaP.visible = true

# Esconde a tecla de ataque ao sair da área do Dummy
func _on_actionArea_area_exited(area):
	$KinematicBody2D/TeclaP.visible = false
	
func _process(delta):
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-20)
