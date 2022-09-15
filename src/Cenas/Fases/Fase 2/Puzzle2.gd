extends Node2D

onready var camera = $Jose/Camera
var isIn = false
var onSword = false
var onSwordsman = false
var talkedSwords = false
var change = 0

func _process(delta):
	$Jose/Camera/Label.text = 'x' + str(GlobalFase2.wood)
	if GlobalFase2.wood >= 1:
		if Input.is_action_just_pressed("interact"):
			for i in range(1,22):
				get_node("Bridge" + str(i)).call('construct')
			if GlobalFase2.hasSword:
				$Bridge22.construct()
			
	
	if Input.is_action_just_pressed("punch"):
		for i in range(1,7):
			get_node("Tree" + str(i)).call('cut')
	
	GlobalFase2.paralax($Jose,$Swordsman)
	GlobalFase2.paralax($Jose,$Sword)
	
	for c in range(1,7):
		GlobalFase2.paralax($Jose,get_node('Tree' + str(c)))
		
	if isIn && Input.is_action_just_pressed("interact"):
		if change%2 == 0:
			camera.zoom.x = 2.3
			camera.zoom.y = 2.3
			change += 1
		else:
			camera.zoom.x = 1
			camera.zoom.y = 1
			change += 1
	
	if change%2 == 1:
		for r in range(1,23):
			get_node("Bridge" + str(r) + "/Ghost").visible = true
			$Quest.visible = true
	elif change%2 == 0:
		for r in range(1,23):
			get_node("Bridge" + str(r) + "/Ghost").visible = false
			$Quest.visible = false
			
	if Input.is_action_just_pressed("interact") && onSword && talkedSwords:
		GlobalFase2.hasSword = true
		$Sword.visible = false
		$Sword/Sword.monitoring = false
		$Sword.collision_layer = 16
		$Sword.collision_mask = 16
		
	if Input.is_action_just_pressed("interact") && onSwordsman:
		$Swordsman/missionBub.visible = false
		talkedSwords = true
		





func _on_Reset_body_entered(body):
	for i in range(1,23):
		get_node("Bridge" + str(i)).call('reset')
	
	for u in range(1,7):
		get_node("Tree" + str(u)).call('reset')
		
	talkedSwords = false
	$Swordsman/missionBub.visible = true
	$Sword.visible = true
	$Sword/Sword.monitoring = true
	$Sword.collision_layer = 1
	$Sword.collision_mask = 1
	
	GlobalFase2.hasSword = false
	GlobalFase2.wood = 2
	change = 0


func _on_Sign_body_entered(body):
	isIn = true

func _on_Sign_body_exited(body):
	isIn = false



func _on_Area2D_body_entered(body):
	if change%2 == 1:
		camera.zoom.x = 1
		camera.zoom.y = 1
		change += 1


func _on_Sword_body_entered(body):
	onSword = true


func _on_Sword_body_exited(body):
	onSword = false


func _on_Swordsman_body_entered(body):
	onSwordsman = true


func _on_Swordsman_body_exited(body):
	onSwordsman = false
