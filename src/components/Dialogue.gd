extends PopupPanel
signal finished()

func show_content(content: String):
	self.popup()
	$MarginContainer/Content.percent_visible = 0
	$MarginContainer/Content.bbcode_text = content
	yield(TweenUtils.tween_property($MarginContainer/Content, "percent_visible", 1, 2), "completed")
#
func _input(event):
	if self.visible and event is InputEventKey:
		self.emit_signal("finished")
		self.hide()


func _on_Dialogue_popup_hide():
	self.emit_signal("finished")
