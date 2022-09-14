extends StaticBody2D

var inside = false


func contruct():
	if inside:
		$Wood.visible = true
		$Block.disabled = true
		$Input.monitoring = false


func _on_Input_body_entered(body):
	inside = true


func _on_Input_body_exited(body):
	inside = false
