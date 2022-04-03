extends Node2D

export (String, FILE) var next_scene_path = null


var trigger_nodes = []
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Mask.visible = false
	
	if self.name in ["Level1", "Level2", "Level3", "Level4", "Level5", "Level6"]:
		$GUI.visible = false
		$Shadow.enabled_delay_control = false
	$Shadow.init($Player)
	for node in self.get_children():
		if node.is_in_group("trigger"):
			trigger_nodes.push_back(node)
			node.connect("trigger_changed", self, "check_win")
	TweenUtils.audio_fade_in($BgmPlayer)
	$BgmPlayer.play()

func check_win():
	var is_win = true
	for node in trigger_nodes:
		is_win = node.triggered if is_win else false
	if is_win:
		$Player.enabled = false
		$Shadow.enabled = false
		$Door.play("opening")
		yield($Door, "animation_finished")
		$Door.play("opened")
		
		yield(self.get_tree().create_timer(2.5), "timeout")
		if self.next_scene_path != null:
			SceneChanger.change_scene(self.next_scene_path)

func _input(event):
	if Input.is_action_pressed("ui_pause"):
		$Popups/PausePanel.popup_centered()
		self.get_tree().paused = true


func _on_Ground_body_entered(body):
	yield(self.get_tree().create_timer(0.5), "timeout")
	SceneChanger.change_scene(self.get_tree().current_scene.filename)


func _process(delta):
	$GUI/MarginContainer/HBoxContainer/Delay/Value.text = "{value} s".format({
		"value": $Shadow.delay
	})


func _on_PausePanel_about_to_show():
	$Mask.visible = true

func _on_PausePanel_popup_hide():
	$Mask.visible = false
