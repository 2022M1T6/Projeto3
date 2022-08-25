extends Node2D

func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	get_tree().change_scene("res://Cenas/Fases/Tutorial/Mapa3/Combate.tscn")
