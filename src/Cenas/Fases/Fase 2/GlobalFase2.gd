extends Node

var wood = 2

func paralax(a,b):
	if a.position.y <= b.position.y:
		b.z_index = 1
	else:
		b.z_index = 0
