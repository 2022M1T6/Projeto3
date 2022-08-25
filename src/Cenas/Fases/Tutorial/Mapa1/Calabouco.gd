extends Node2D

# Ao entrar na área, muda a cena
func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa2/Labirinto.tscn")


func _on_TutoraiMapa1Fala1_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	$Jose/Camera2D/CanvasLayer/Hint.text = ' -> Procure e vá até Dellson'


func _on_TutoraiMapa1Fala2_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	$Jose/Camera2D/CanvasLayer/Hint.visible = false


func _on_TutoraiMapa1Fala2_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	$Jose/Camera2D/CanvasLayer/Hint.text = ' -> Vá até a próxima área atrás de Dellson'
	$Jose/Camera2D/CanvasLayer/Hint.visible = true
