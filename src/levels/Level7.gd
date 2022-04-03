extends "res://src/levels/BaseLevel.gd"

func _ready():
	if not GameManager.flags.level7_hint:
		yield(self.get_tree().create_timer(1), "timeout")
		$Mask.visible = true
		$Popups/Dialogue.show_content("You gain the power to control your shadow DELAY! Press Q to increse delay, W to reduce delay.")
		yield($Popups/Dialogue, "finished")
		$Mask.visible = false
		GameManager.flags.level7_hint = true
