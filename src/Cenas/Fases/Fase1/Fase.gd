extends Node2D

func _ready():
	$Jose/Camera2D/CanvasLayer/PopupMinigame.hide()

func _on_Area2D2_area_entered(area):
	get_tree().paused = true
	$Jose/Camera2D/CanvasLayer/PopupMinigame.show()
	$Jose/Camera2D/CanvasLayer/PopupMinigame/Control.show()
