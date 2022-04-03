extends Area2D

export var start_time = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.frame = 0
	$CollisionShape2D.disabled = true
	yield(self.get_tree().create_timer(start_time), "timeout")
	$Timer.start()
	self._on_Timer_timeout()

func _on_Timer_timeout():
	$AnimationPlayer.play("showing")
	yield($AnimationPlayer, "animation_finished")
	yield(self.get_tree().create_timer(0.5), "timeout")
	$AnimationPlayer.play("close")
	


func _on_Spike_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if not body.is_in_group("shadow"):
		yield(body.dead(), "completed")
		SceneChanger.change_scene(self.get_tree().current_scene.filename)
