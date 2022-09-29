extends Node2D


func _process(delta):
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-5)


func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	$Player/Camera2D/CanvasLayer/Control.sendQuiz()
	
