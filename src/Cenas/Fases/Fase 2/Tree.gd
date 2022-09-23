extends StaticBody2D
# CÓDIGO EM PRODUÇÃO - NÃO PLANEJAMOS ENTREGAR NA SPRINT 4.
# ESSE CÓDIGO AINDA NÃO FOI FINALIZADO, PORTANTO AINDA IRÁ SER COMPLETO E REFATORADO
var isOn = false

func cut():
	if isOn:
		$CollisionShape2D.disabled = true
		$ColorRect.visible = false
		$Area2D.monitoring = false
		GlobalFase2.wood += 2



func _on_Area2D_body_entered(body):
	isOn = true


func _on_Area2D_body_exited(body):
	isOn = false
	
func reset():
	$CollisionShape2D.disabled = false
	$ColorRect.visible = true
	$Area2D.monitoring = true
