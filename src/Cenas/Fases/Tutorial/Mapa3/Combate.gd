extends Node2D

onready var HP = $KinematicBody2D/Label
var currentHP = 60
var maxHP = 60
var dano = 20


func _ready():
	$Player/PunchSound.volume_db = GlobalOptions.setSFXSound(float($Player/PunchSound.volume_db))
	$Player/RunningSound.volume_db = GlobalOptions.setSFXSound(float($Player/RunningSound.volume_db))
	$Player/WalkingSound.volume_db = GlobalOptions.setSFXSound(float($Player/WalkingSound.volume_db))
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(float($AudioStreamPlayer2D.volume_db))
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
		
func _on_Hurtbox_area_entered(area):
	currentHP -= dano
	HP.text = str(currentHP)
	
	if currentHP <= 1:
		$Area2D.monitoring = true
		$Area2D3.monitoring = true
		currentHP = 0
		$KinematicBody2D.queue_free()
	
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
	

func _on_Area2D_area_entered(area):
	if currentHP <= 0:
		get_tree().change_scene("res://Cenas/Fases/Fase1/Fase.tscn")

	
func _on_Area2D2_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if GlobalOptions.isPortuguese:
		$Player/Camera2D/CanvasLayer/Hint.sendHint('Destrua o boneco de testes usando P e vá até a porta escura')
	else:
		$Player/Camera2D/CanvasLayer/Hint.sendHint('Beat the dummy using P and cross the gate')
	

func _on_Area2D3_area_entered(area):
	$Dellson/Sprite.flip_h = true
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
	
func _on_Area2D3_area_exited(area):
	if currentHP <= 0:
		$Dellson.queue_free()


func _on_actionArea_area_entered(area):
	$KinematicBody2D/TeclaP.visible = true


func _on_actionArea_area_exited(area):
	$KinematicBody2D/TeclaP.visible = false
