extends Node2D




func _process(delta):
	if GlobalFase2.wood >= 1:
		if Input.is_action_just_pressed("interact"):
			for i in range(1,23):
				get_node("Bridge" + str(i)).call('construct')
	
	if Input.is_action_just_pressed("punch"):
		for i in range(1,7):
			get_node("Tree" + str(i)).call('cut')
	
	print($Bridge1/Block.disabled)






func _on_Reset_body_entered(body):
	for i in range(1,23):
		get_node("Bridge" + str(i)).call('reset')
	
	for u in range(1,7):
		get_node("Tree" + str(u)).call('reset')
	
	GlobalFase2.wood = 2
