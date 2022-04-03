extends "res://src/sprites/BaseSprite.gd"

const MIN_DELAY = 0
const MAX_DELAY = 2
var delay = 0.6

var owner_sprite = null
var enabled_delay_control = true

func init(owner_sprite):
	self.owner_sprite = owner_sprite

func add_command(command: String):
	self.commands.push_back({ "command": command, "delay": delay })

func _input(event):
	if not self.enabled_delay_control:
		return
	if Input.is_action_just_pressed("player_delay_up"):
		delay = min(delay + 0.1, MAX_DELAY)
	if Input.is_action_just_pressed("player_delay_down"):
		delay = max(delay - 0.1, MIN_DELAY)
