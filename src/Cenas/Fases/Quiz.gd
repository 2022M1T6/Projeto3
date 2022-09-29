extends Control

var respostas = [["Porque ele corre maratonas", "Porque ele treina muito", "Porque ele come muito", "Porque ele dá o c#"], ["Porque ele é mineiro", "Porque ele não resiste uma gringa", "Porque o Renan vacila muito", "Porque ele é"]]
var perguntas = {"Pergunta 1:\n\nPor que o Bruno é gordo?": "C", "Pergunta 2:\n\nPor que o Yago é talarico?": "B"}
var contador = 0
var erros = 0
var acertos = 0

func _ready():
	print('lol')
	$Pergunta.text = str(perguntas.keys()[contador])
	
	$botaoA.text = respostas[contador][0]
	$botaoB.text = respostas[contador][1]
	$botaoC.text = respostas[contador][2]
	$botaoD.text = respostas[contador][3]
	
	$"CoraçaoQuebrado1".hide()
	$"CoraçaoQuebrado2".hide()
	$"CoraçaoQuebrado3".hide()
	

func mudar_pergunta():
	contador += 1
	
	if contador >= 2:
		return
	$Pergunta.text = perguntas.keys()[contador]
	
	$botaoA.text = respostas[contador][0]
	$botaoB.text = respostas[contador][1]
	$botaoC.text = respostas[contador][2]
	$botaoD.text = respostas[contador][3]

func errar():
	erros += 1
	var string_coracao = "Coracao" + str(erros)
	var string_quebrado = "CoraçaoQuebrado" + str(erros)
	get_node(string_coracao).hide()
	get_node(string_quebrado).show()
	
	if erros >= 3:
		get_tree().change_scene("res://Cenas/Fases/Quiz.tscn")
	

func acertar():
	acertos += 1
	$Acertos.text = str(acertos) + "/2"
	
	if acertos >= 2:
		get_tree().change_scene("res://Cenas/Menus/MenuOpcoes.tscn")
	
func _on_botaoA_pressed():
	print('oi')
	if perguntas[$Pergunta.text] == 'A':
		acertar()
	else:
		errar()
	mudar_pergunta()	


func _on_botaoB_pressed():
	if perguntas[$Pergunta.text] == 'B':
		acertar()
	else:
		errar()
	mudar_pergunta()


func _on_botaoC_pressed():
	if perguntas[$Pergunta.text] == 'C':
		acertar()
	else:
		errar()
	mudar_pergunta()


func _on_botaoD_pressed():
	if perguntas[$Pergunta.text] == 'D':
		acertar()
	else:
		errar()
	mudar_pergunta()
	
func sendQuiz():
	GlobalOptions.hideHUDItems()
	get_tree().paused = true
	show()
