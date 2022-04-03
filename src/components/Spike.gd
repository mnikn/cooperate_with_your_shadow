extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$AnimationPlayer.play("showing")
	yield($AnimationPlayer, "animation_finished")
	yield(self.get_tree().create_timer(0.5), "timeout")
	$AnimationPlayer.play("close")
	


func _on_Spike_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print_debug("lose")
	yield(self.get_tree().create_timer(0.5), "timeout")
	SceneChanger.change_scene(self.get_tree().current_scene.filename)
