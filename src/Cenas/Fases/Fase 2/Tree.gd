extends StaticBody2D

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
