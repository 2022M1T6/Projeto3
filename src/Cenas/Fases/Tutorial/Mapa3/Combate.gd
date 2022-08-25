extends Node2D

var maxHP = 60
var currentHP
var dano = 20

onready var HP = $KinematicBody2D/Label

func _ready():
	currentHP = maxHP

func _on_Hurtbox_area_entered(area):
	currentHP -= dano
	HP.text = str(currentHP)
	if currentHP <= 1:
		$Area2D.monitoring = true
		currentHP = maxHP

func _on_Area2D_area_entered(area):
	get_tree().change_scene("res://Cenas/Fases/Fase1/Fase1.tscn")


func _on_Area2D3_area_entered(area):
	$Dellson1.flip_h = false


func _on_Area2D4_area_entered(area):
	$Dellson1.hide()


func _on_Area2D2_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	$Jose/Camera2D/CanvasLayer/Hint.text = ' -> Destrua o boneco de testes usando P e vá até a porta escura'
