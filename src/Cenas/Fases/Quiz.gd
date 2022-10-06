extends Control

var respostas = [
["É a organização de uma equipe que busca definir os principais objetivos da empresa que deve ser alcançado em uma data específica", "É o que a empresa quer se tornar curto prazo", "É uma declaração de intenção indicando o que equipe não quer se tornar", "É uma declaração de intenção indicando o que uma equipe quer se tornar que oriente iniciativas de transformação e defina uma direção para o crescimento futuro"],
["Planejamento", "Realizar testes", "Interpretação do problema", "Análise de soluções existentes"],
['As mais simples/direcionadas','As que contém mais funcionalidades','As mais facilmente compreendidas','As que possuem maior custo benefício'],
['Um machado bonito','Um machado mais eficiente em combate','Um machado mais eficiente em cortar árvores','Um machado que o rei aprove'],
['Colocar em prática o que aprendeu','Traçar estratégias e um plano de ação para ajudar na orientação e organização do projeto','Aplicar o que se aprendeu na dimensão visão','Solucionar problemas de maneira eficaz, traçando estratégias a cada passo'],
['Adicionar mais funcionalidades não previstas','Procurar mais investidores','Não há necessidade de iteração','Adaptar o plano de ação com base nos resultados até o momento']]
var perguntas = {
"Pergunta 1:\n\nO que é visão?": "D", 
"Pergunta 2:\n\nQual deve ser a primeira parte no desenvolvimento de uma solução?": "C", 
"Pergunta 3:\n\nSegundo o lenhador, qual o tipo de ferramenta que trás as melhores soluções?": "A",
"Pergunta 4:\n\nQual a métrica encontrada na primeira fase para o machado correto?": "C",
"Pergunta 5:\n\nO que é roadmap?": "B",
"Pergunta 6:\n\nQual a importância da iteração no roadmap?":'D'}
var contador = 0
var erros = 0
var acertos = 0

func _ready():
	
	# Muda o idioma das perguntas e respostas caso o jogo esteja em inglês
	if !GlobalOptions.isPortuguese:
		perguntas = {
		"Question 1:\n\nWhat is vision?": "D", 
		"Question 2:\n\nWhat is the first part on developing a solution?": "C", 
		"Question 3:\n\nAccording to the lumberjack, what type of tool brings the best solutions?": "A",
		"Question 4:\n\nWhat is the success metric for the axe created in the first level?": "C",
		"Question 5:\n\nWhat is roadmap?": "B",
		"Question 6:\n\nWhat is the importance of iteration on roadmap?":'D'}
		respostas[0][0] = "It's a team's structure that defines the primary objetives of the company for a determined deadline"
		respostas[0][1] = "It's the company's short term goal"
		respostas[0][2] = "It's a statement of what the business sought to not become"
		respostas[0][3] = "It's a statement that shows what a corporation wants to become, used for setting transformation iniciatives and defining a direction for future growth"
		
		respostas[1][0] = 'Planning'
		respostas[1][1] = 'Testing'
		respostas[1][2] = 'Understanding the problem'
		respostas[1][3] = 'Analysing market solutions'
		
		respostas[2][0] = 'The simplest'
		respostas[2][1] = 'The one with more functions'
		respostas[2][2] = 'The easiest to understand'
		respostas[2][3] = 'The one with the best cost-benefit ratio'
		
		respostas[3][0] = "A beutiful axe"
		respostas[3][1] = "A good battle axe"
		respostas[3][2] = "A good axe for cutting trees"
		respostas[3][3] = "A axe that the king approves"
		
		respostas[4][0] = "Doing what was practiced"
		respostas[4][1] = "Making strategies and a action plan to organize and guide the project"
		respostas[4][2] = "Using what was learned during the vision dimension"
		respostas[4][3] = "Solving the problem efficiently, creating steps along the way"
		
		respostas[5][0] = "Adding more functionalities that weren't planned"
		respostas[5][1] = "Searching for investors"
		respostas[5][2] = "There's no need to iterate"
		respostas[5][3] = "Adapt the action plan according to the results obtained"
		
	$Pergunta.text = str(perguntas.keys()[contador])
	
	$botaoA/Label.text = respostas[contador][0]
	$botaoB/Label.text = respostas[contador][1]
	$botaoC/Label.text = respostas[contador][2]
	$botaoD/Label.text = respostas[contador][3]
	
	$"CoraçaoQuebrado1".hide()
	$"CoraçaoQuebrado2".hide()
	$"CoraçaoQuebrado3".hide()
	
	# Envia os diálogos iniciais
	if GlobalOptions.isPortuguese:
		$Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"Uau, você conseguiu fazer todos os desafios até agora e eu acho que você evoluiu como profissional.",
					'Mas agora está na hora de testar o quanto voce aprendeu',
					'Venha, e me mostre o seu novo conhecimento!!'
				]
			}
		])
	else:
		$Camera2D/CanvasLayer/PopupDialog.sendDialog([
			{
				"personagem": "dellson",
				"falas": [
					"Wow, you did all the challenges until now and I think you've elvolved as a professional.",
					'But now is the time to test your new knowledge.',
					'Come, and show me your what have you learned!!'
				]
			}
		])
	
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-5)
	
# Muda a pergunta e as respostas apresentadas
func mudar_pergunta():
	contador += 1
	
	if contador >= 6:
		return
	$Pergunta.text = perguntas.keys()[contador]
	
	$botaoA/Label.text = respostas[contador][0]
	$botaoB/Label.text = respostas[contador][1]
	$botaoC/Label.text = respostas[contador][2]
	$botaoD/Label.text = respostas[contador][3]

# Perde vida (coração) ao errar
func errar():
	erros += 1
	var string_coracao = "Coracao" + str(erros)
	var string_quebrado = "CoraçaoQuebrado" + str(erros)
	get_node(string_coracao).hide()
	get_node(string_quebrado).show()
	
	if erros >= 3:
		get_tree().change_scene("res://Cenas/Utilitarios/Gameover.tscn")
	
# Ganha ponto de acerto ao acertar
func acertar():
	acertos += 1
	$Acertos.text = str(acertos) + "/6"
	
	if acertos >= 6:
		get_tree().change_scene("res://Cenas/Utilitarios/Creditos.tscn")
	
# Função para quando o botão "botaoA" é pressionado
func _on_botaoA_pressed():
	if perguntas[$Pergunta.text] == 'A':
		acertar()
		mudar_pergunta()
	else:
		errar()

# Função para quando o botão "botaoB" é pressionado
func _on_botaoB_pressed():
	if perguntas[$Pergunta.text] == 'B':
		acertar()
		mudar_pergunta()
	else:
		errar()

# Função para quando o botão "botaoC" é pressionado
func _on_botaoC_pressed():
	if perguntas[$Pergunta.text] == 'C':
		acertar()
		mudar_pergunta()
	else:
		errar()
	
# Função para quando o botão "botaoD" é pressionado
func _on_botaoD_pressed():
	if perguntas[$Pergunta.text] == 'D':
		acertar()
		mudar_pergunta()
	else:
		errar()
		
func _process(delta):
	$AudioStreamPlayer2D.volume_db = GlobalOptions.setMusicSound(-5)
	

