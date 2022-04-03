extends PopupPanel

func _on_Continue_pressed():
	self.hide()
	self.get_tree().paused = false


func _on_Restart_pressed():
	self.hide()
	SceneChanger.change_scene(self.get_tree().current_scene.filename)
	self.get_tree().paused = false


func _on_Title_pressed():
	self.hide()
	SceneChanger.change_scene("res://src/Main.tscn")
	self.get_tree().paused = false
	
