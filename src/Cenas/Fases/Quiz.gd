extends Control

var respostas = [["É a organização de uma equipe que busca definir os principais objetivos da empresa que deve ser alcançado em uma data específica", "É o que a empresa quer se tornar curto prazo", "É uma declaração de intenção indicando o que uma empresa, unidade de negócio ou equipe não quer se tornar", "É uma declaração de intenção indicando o que uma empresa, unidade de negócio ou equipe quer se tornar e orientando iniciativas de transformação, definindo uma direção definida para o crescimento futuro"],
["Planejamento", "Realizar testes", "Interpretação do problema", "Análise de soluções existentes"],['As mais simples/direcionadas','As que contém mais funcionalidades','As mais facilmente compreendidas','As que possuem maior custo benefício'],
['Um machado bonito','Um machado mais eficiente em combate','Um machado mais eficiente em cortar árvores','Um machado que o rei aprove'],
['Colocar em prática o que aprendeu','Traçar estratégias e um plano de ação para ajudar na orientação e organização do projeto','Aplicar o que se aprendeu na dimensão visão','Solucionar problemas de maneira eficaz, traçando estratégias a cada passo'],
['Fazer mudanças com base nos resultados',' Mapear os elementos mais importantes e colocá los em prática durante o projeto','Definir etapas antes da criação do projeto para que seja possível ter um resultado mais eficiente','Deve-se definir tudo que será executado durante o projeto para que não haja erros']]
var perguntas = {"Pergunta 1:\n\nO que é visão?": "D", "Pergunta 2:\n\nQual deve ser a primeira parte no desenvolvimento de uma solução?": "C", "Pergunta 3:\n\nSegundo o lenhador, qual o tipo de ferramenta que trás as melhores soluções?": "A",
"Pergunta 4:\n\nQual a métrica encontrada na primeira fase para o machado correto?": "C","Pergunta 5:\n\nO que é roadmap?": "B",
"Pergunta 6:\n\nQuais os elementos mais importantes no roadmap?": "A"}
var contador = 0
var erros = 0
var acertos = 0

func _ready():
	print('lol')
	$Pergunta.text = str(perguntas.keys()[contador])
	
	$botaoA/Label.text = respostas[contador][0]
	$botaoB/Label.text = respostas[contador][1]
	$botaoC/Label.text = respostas[contador][2]
	$botaoD/Label.text = respostas[contador][3]
	
	$"CoraçaoQuebrado1".hide()
	$"CoraçaoQuebrado2".hide()
	$"CoraçaoQuebrado3".hide()
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
	
	

func mudar_pergunta():
	contador += 1
	
	if contador >= 8:
		return
	$Pergunta.text = perguntas.keys()[contador]
	
	$botaoA/Label.text = respostas[contador][0]
	$botaoB/Label.text = respostas[contador][1]
	$botaoC/Label.text = respostas[contador][2]
	$botaoD/Label.text = respostas[contador][3]

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
	$Acertos.text = str(acertos) + "/8"
	
	if acertos >= 8:
		get_tree().change_scene("res://Cenas/Menus/MenuOpcoes.tscn")
	
func _on_botaoA_pressed():
	if perguntas[$Pergunta.text] == 'A':
		acertar()
		mudar_pergunta()
	else:
		errar()



func _on_botaoB_pressed():
	if perguntas[$Pergunta.text] == 'B':
		acertar()
		mudar_pergunta()
	else:
		errar()



func _on_botaoC_pressed():
	if perguntas[$Pergunta.text] == 'C':
		acertar()
		mudar_pergunta()
	else:
		errar()
	


func _on_botaoD_pressed():
	if perguntas[$Pergunta.text] == 'D':
		acertar()
		mudar_pergunta()
	else:
		errar()
	

