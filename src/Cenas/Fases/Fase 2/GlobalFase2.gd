extends Node
var wood = 2
var hasSword= false

func paralax(a,b):
	if a && b:
		if a.position.y <= b.position.y:
			b.z_index = 1
		else:
			b.z_index = 0
