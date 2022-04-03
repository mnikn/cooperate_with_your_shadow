extends Node2D


func _input(event):
	if Input.is_action_pressed("ui_accept"):
		SceneChanger.change_scene("res://src/levels/Level1.tscn")
