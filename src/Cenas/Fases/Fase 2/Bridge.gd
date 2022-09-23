extends StaticBody2D
# CÓDIGO EM PRODUÇÃO - NÃO PLANEJAMOS ENTREGAR NA SPRINT 4.
# ESSE CÓDIGO AINDA NÃO FOI FINALIZADO, PORTANTO AINDA IRÁ SER COMPLETO E REFATORADO
var inside = false


func construct():
	if inside:
		$Wood.visible = true
		self.collision_layer = 32
		self.collision_mask = 32
		$Input.monitoring = false
		GlobalFase2.wood -= 1

func reset():
	$Wood.visible = false
	self.collision_layer = 1
	self.collision_mask = 1
	$Input.monitoring = true


func _on_Input_body_entered(body):
	inside = true

func _on_Input_body_exited(body):
	inside = false
