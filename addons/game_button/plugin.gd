tool
extends EditorPlugin


func _enter_tree():
	self.add_custom_type("GameButton", "Button", preload("game_button.gd"), null)

func _exit_tree():
	self.remove_custom_type("GameButton")
