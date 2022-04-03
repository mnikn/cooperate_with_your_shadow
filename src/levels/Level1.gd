extends "res://src/levels/BaseLevel.gd"

func _ready():
	if not GameManager.flags.level1_hint:
		yield(self.get_tree().create_timer(1), "timeout")
		$Mask.visible = true
		$Popups/Dialogue.show_content("You need to cooperte with your shadow, triggered all trigger to open the door. But  beacuse is your shadow, so your shadow DELAY IS INEVITABLE! ")
		yield($Popups/Dialogue, "finished")
		$Mask.visible = false
		GameManager.flags.level1_hint = true
