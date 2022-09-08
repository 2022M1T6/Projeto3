extends KinematicBody2D

# Executa eternamente a animação padrão
func _process(delta):
	$AnimationPlayer.play("idle")
