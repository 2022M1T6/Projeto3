extends Node2D

onready var wood = [$Bridge0/Wood,$Bridge1/Wood]
onready var blockade = [$Bridge0/Blockade,$Bridge1/Blockade]
onready var plate = [$Bridge0/Plate0,$Bridge1/Plate1]
var inside = [false,false]


func _process(delta):
	print(inside[0])
	if Input.is_action_just_pressed("interact"):
		for i in range(len(inside)):
			if inside[i] == true:
				wood[i].visible = true
				blockade[i].disabled = true
				plate[i].monitoring = false



func _on_Plate0_body_entered(body):
	inside[0] = true


func _on_Plate1_body_entered(body):
	inside[1] = true


func _on_Plate0_body_exited(body):
	inside[0] = false


func _on_Plate1_body_exited(body):
	inside[1] = false
