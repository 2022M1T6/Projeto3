extends Node2D

# Ao entrar na área, muda a cena
func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa2/Labirinto.tscn")
