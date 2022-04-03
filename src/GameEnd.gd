extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Mask.visible = true
	$Popups/Dialogue.show_content("Congratulation! You have clear the game! Thanks for playing!")
	yield($Popups/Dialogue, "finished")
	$Mask.visible = false
	SceneChanger.change_scene("res://src/Main.tscn")
