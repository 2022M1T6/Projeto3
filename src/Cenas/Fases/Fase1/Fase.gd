extends Node2D

var enteredTreeArea = false

func _ready():
	$Jose/Camera2D/CanvasLayer/PopupMinigame.hide()
	
	$TreeAndRocks/TreeArea2D.monitoring = false

func _on_Area2D2_area_entered(area):
	GlobalFase1.axeChoicedParts = []
	get_tree().paused = true
	$Jose/Camera2D/CanvasLayer/PopupMinigame.show()
	$Jose/Camera2D/CanvasLayer/PopupMinigame/Control.show()

func _process(delta):
	if(GlobalFase1.AxeOk):
		$Blacksmith/MinigameArea2D.visible = false
		$Blacksmith/MinigameArea2D.monitoring = false
		
		$TreeAndRocks/TreeArea2D.monitoring = true
		
func _physics_process(delta):
	$Blacksmith/MinigameArea2D.monitoring = GlobalFase1.blacksmithTalk
	
	if GlobalFase1.kingTalk == true:
		$Sprite2.visible = false
		$Sprite3.visible = true
		if GlobalFase1.blacksmithTalk == false:
			$Sprite4.visible = true
		else:
			$Sprite4.visible = false
	
	if Input.is_action_just_pressed("punch") && enteredTreeArea:
		$TreeAndRocks/Treelog.queue_free()
	
	if Input.is_action_just_pressed("interact"):
		$Marketer/Marketer.monitoring = true
		$King/King.monitoring = true
		$Blacksmith/Blacksmith.monitoring = true
		$Lumberjack/Lumberjack.monitoring = true
	else:
		$Marketer/Marketer.monitoring = false
		$King/King.monitoring = false
		$Blacksmith/Blacksmith.monitoring = false
		$Lumberjack/Lumberjack.monitoring = false
		
func _on_TreeArea2D_area_entered(area):
	enteredTreeArea = true
	
func _on_TreeArea2D_area_exited(area):
	enteredTreeArea = false





func _on_Area2D_area_entered(area):
	get_tree().change_scene("res://Cenas/Utilitarios/FimDemo.tscn")
