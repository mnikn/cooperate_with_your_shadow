extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Level1_pressed():
	SceneChanger.change_scene("res://src/levels/Level1.tscn")


func _on_Level2_pressed():
	SceneChanger.change_scene("res://src/levels/Level2.tscn")


func _on_Level3_pressed():
	SceneChanger.change_scene("res://src/levels/Level3.tscn")
