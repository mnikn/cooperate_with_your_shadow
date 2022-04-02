extends StaticBody2D
signal trigger_changed()

var triggered = false


func _on_Detector_body_entered(body):
#	yield(self.get_tree().create_timer(0.05),"timeout")
	if len($Detector.get_overlapping_bodies()) > 0:
		$Sprite.texture = load("res://assets/tileset/trigger_active.png")
		self.triggered = true
		self.emit_signal("trigger_changed")

func _on_Detector_body_exited(body):
	yield(self.get_tree().create_timer(0.2),"timeout")
	if len($Detector.get_overlapping_bodies()) <= 0:
		$Sprite.texture = load("res://assets/tileset/trigger.png")
		self.triggered = false
		self.emit_signal("trigger_changed")
