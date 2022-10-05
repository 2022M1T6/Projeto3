extends Node

var blacksmithTalk = false
var kingTalk = false


# Guarda qual machado o usuário ta editando durante o minigame
var choicedCards = []

# Guarda qual machado o usuário escolheu no último minigame
var axeChoicedParts = []

# Informações das cartas do minigame em português
var cardsP = [
	[
		{
			'titulo': 'Cabo de Madeira',
			'sprite': "res://Public/Minigame1/caboMadeira.png",
			'descricao': 'O clássico, melhor escolha para machado de lenhadores.',
			'position': Vector2(100, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Cabo de Aço',
			'sprite': "res://Public/Minigame1/caboAco.png",
			'descricao': 'Muito resistente, pesado e o melhor para batalhas.',
			'position': Vector2(400, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Cabo de Madeira Curto',
			'sprite': "res://Public/Minigame1/caboMadeiraCurto.png",
			'descricao': 'Um cabo excelente para arremessos.',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	],
	[
		{
			'titulo': 'Lâmina dupla',
			'sprite': "res://Public/Minigame1/laminaDupla.png",
			'descricao': 'A cabeça de machado que mais amedronta os inimigos.',
			'position': Vector2(100, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Lâmina de Fio Único',
			'sprite': "res://Public/Minigame1/laminaSimples.png",
			'descricao': 'Forjada com o formato perfeito para cortar madeira.',
			'position': Vector2(400, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Lâmina Pesada',
			'sprite': "res://Public/Minigame1/laminaPesada.png",
			'descricao': 'Utilizada por guerreiros muito fortes.',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	],
	[
		{
			'titulo': 'Cabeçote de Madeira',
			'sprite': "res://Public/Minigame1/cabecoteMadeira.png",
			'descricao': 'A escolha favorita de todos: versátil e universal.',
			'position': Vector2(100, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Cabeçote de Aço',
			'sprite': "res://Public/Minigame1/cabecoteAco.png",
			'descricao': 'Resistente, mas aumenta demais o peso no topo do machado.',
			'position': Vector2(400, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Cabeçote pontudo',
			'sprite': "res://Public/Minigame1/cabecoteLamina.png",
			'descricao': 'Uma lâmina a mais para ferir seu inimigo.',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	]
]

#Informações das cartas do minigame em inglês
var cardsE = [
	[
		{
			'titulo': 'Wood Handle',
			'sprite': "res://Public/Minigame1/caboMadeira.png",
			'descricao': "The best choice for a lumberjack's axe.",
			'position': Vector2(100, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Steel Handle',
			'sprite': "res://Public/Minigame1/caboAco.png",
			'descricao': 'Very resistant and heavy. The best for bloodshed.',
			'position': Vector2(400, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Small Wood Handle',
			'sprite': "res://Public/Minigame1/caboMadeiraCurto.png",
			'descricao': 'An excellent handle for throwing.',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	],
	[
		{
			'titulo': 'Double Bit',
			'sprite': "res://Public/Minigame1/laminaDupla.png",
			'descricao': 'A bit that paralyse its enemys with fear',
			'position': Vector2(100, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Single Bit',
			'sprite': "res://Public/Minigame1/laminaSimples.png",
			'descricao': 'Excellent shape for manual labor. The best at cutting trees',
			'position': Vector2(400, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Heavy Bit',
			'sprite': "res://Public/Minigame1/laminaPesada.png",
			'descricao': 'The heaviest. Used by very strong warriors',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	],
	[
		{
			'titulo': 'Wood Eye',
			'sprite': "res://Public/Minigame1/cabecoteMadeira.png",
			'descricao': 'Everyones favorite. Truly versatile and universal',
			'position': Vector2(100, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Steel Eye',
			'sprite': "res://Public/Minigame1/cabecoteAco.png",
			'descricao': 'Not very useful. Makes the top heavier',
			'position': Vector2(400, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Pointy Eye',
			'sprite': "res://Public/Minigame1/cabecoteLamina.png",
			'descricao': 'One more opportunity to hurt your enemy',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	]
]

# Guarda um booleano se todas as partes do machado estão ok
var AxeOk = false
