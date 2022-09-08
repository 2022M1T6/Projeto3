extends Node2D

var enteredTreeArea = false

func _ready():
	$Jose/Camera2D/CanvasLayer/PopupMinigame.hide()
	
	$TreeAndRocks/TreeArea2D.monitoring = false

func _on_Area2D2_area_entered(area):
	get_tree().paused = true
	$Jose/Camera2D/CanvasLayer/PopupMinigame.show()
	$Jose/Camera2D/CanvasLayer/PopupMinigame/Control.show()

func _process(delta):
	if(GlobalFase1.AxeOk):
		$Blacksmith/MinigameArea2D.visible = false
		$Blacksmith/MinigameArea2D.monitoring = false
		
		$TreeAndRocks/TreeArea2D.monitoring = true
		
func _physics_process(delta):
	if Input.is_action_just_pressed("attack") && enteredTreeArea:
		$TreeAndRocks/Treelog.queue_free()

func _on_TreeArea2D_area_entered(area):
	enteredTreeArea = true
	
func _on_TreeArea2D_area_exited(area):
	enteredTreeArea = false
