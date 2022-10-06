extends Popup


func sendQuiz():
	GlobalOptions.hideHUDItems()
	get_tree().paused = true
	show()
