extends Node

var choicedCards = []
var cards = [
	[
		{
			'titulo': 'Cabo de Madeira',
			'sprite': "res://Public/Minigame1/caboMadeira.png",
			'descricao': 'Cabo leve e resistente com tamanho médio',
			'position': Vector2(100, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Cabo de Aço',
			'sprite': "res://Public/Minigame1/caboAco.png",
			'descricao': 'Cabo pesado, muito resistente e tamanho longo',
			'position': Vector2(400, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Cabo de Madeira Curto',
			'sprite': "res://Public/Minigame1/caboMadeiraCurto.png",
			'descricao': 'Cabo leve e resistente com tamanho curto',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	],
	[
		{
			'titulo': 'Lâmina dupla',
			'sprite': "res://Public/Minigame1/laminaDupla.png",
			'descricao': 'Corte nos dois lados, ideal para batalhas',
			'position': Vector2(100, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Lâmina simples',
			'sprite': "res://Public/Minigame1/laminaSimples.png",
			'descricao': 'Lâmina balanceada para um lado',
			'position': Vector2(400, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Lâmina longa',
			'sprite': "res://Public/Minigame1/laminaLonga.png",
			'descricao': 'Lâmina pesada balanceada para um lado',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	],
	[
		{
			'titulo': 'Cabeçote de Madeira',
			'sprite': "res://Public/Minigame1/cabecoteMadeira.png",
			'descricao': 'Da para o gasto',
			'position': Vector2(100, 50),
			'correto': false,
			'objeto': false
		},
		{
			'titulo': 'Cabeçote de Aço',
			'sprite': "res://Public/Minigame1/cabecoteAco.png",
			'descricao': 'Fornece mais peso para a cabeça, mais resistente',
			'position': Vector2(400, 50),
			'correto': true,
			'objeto': false
		},
		{
			'titulo': 'Cabeçote pontudo',
			'sprite': "res://Public/Minigame1/cabecoteLamina.png",
			'descricao': 'Feito de aço, é uma lâmina a mais para garantir ataque',
			'position': Vector2(700, 50),
			'correto': false,
			'objeto': false
		}
	]
]
