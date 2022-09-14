extends Node

var blacksmithTalk = false
var kingTalk = false

# Guarda qual machado o usuário ta editando durante o minigame
var choicedCards = []

# Guarda qual machado o usuário escolheu no último minigame
var axeChoicedParts = []

# Informações das cartas do minigame
var cards = [
	[
		{
			'titulo': 'Cabo de Madeira',
			'sprite': "res://Public/Minigame1/caboMadeira.png",
			'descricao': 'O clássico, mais duro do que você imaginava',
			'position': Vector2(100, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Cabo de Aço',
			'sprite': "res://Public/Minigame1/caboAco.png",
			'descricao': 'Muito resistente mas muito pesado',
			'position': Vector2(400, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Cabo de Madeira Curto',
			'sprite': "res://Public/Minigame1/caboMadeiraCurto.png",
			'descricao': 'Ele mal cabe na sua mão',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	],
	[
		{
			'titulo': 'Lâmina dupla',
			'sprite': "res://Public/Minigame1/laminaDupla.png",
			'descricao': 'Para batalhas e instigar medo no inimigo',
			'position': Vector2(100, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Lâmina de Fio Único',
			'sprite': "res://Public/Minigame1/laminaSimples.png",
			'descricao': 'Só de encostar na lâmina, você já cortou seu dedo',
			'position': Vector2(400, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Lâmina Pesada',
			'sprite': "res://Public/Minigame1/laminaPesada.png",
			'descricao': 'Ideal para usos curtos e pessoas muito fortes',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	],
	[
		{
			'titulo': 'Cabeçote de Madeira',
			'sprite': "res://Public/Minigame1/cabecoteMadeira.png",
			'descricao': 'Parece que foi feito com algum tipo de cola de madeira',
			'position': Vector2(100, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Cabeçote de Aço',
			'sprite': "res://Public/Minigame1/cabecoteAco.png",
			'descricao': 'Fornece mais peso para a cabeça, mais resistente',
			'position': Vector2(400, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Cabeçote pontudo',
			'sprite': "res://Public/Minigame1/cabecoteLamina.png",
			'descricao': 'É uma lâmina a mais para garantir ataque',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	]
]

# Guarda um booleano se todas as partes do machado estão ok
var AxeOk = false
