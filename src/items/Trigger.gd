extends StaticBody2D


func _on_Detector_body_entered(body):
#	yield(self.get_tree().create_timer(0.05),"timeout")
	if len($Detector.get_overlapping_bodies()) > 0:
		$Sprite.texture = load("res://assets/tileset/trigger_active.png")

func _on_Detector_body_exited(body):
	yield(self.get_tree().create_timer(0.2),"timeout")
	if len($Detector.get_overlapping_bodies()) <= 0:
		$Sprite.texture = load("res://assets/tileset/trigger.png")
