extends Node
# CÓDIGO EM PRODUÇÃO - NÃO PLANEJAMOS ENTREGAR NA SPRINT 4.
# ESSE CÓDIGO AINDA NÃO FOI FINALIZADO, PORTANTO AINDA IRÁ SER COMPLETO E REFATORADO
var wood = 2
var hasSword= false

func paralax(a,b):
	if a && b:
		if a.position.y <= b.position.y:
			b.z_index = 1
		else:
			b.z_index = 0
