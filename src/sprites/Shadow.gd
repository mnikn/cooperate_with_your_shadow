extends "res://src/sprites/BaseSprite.gd"

export var delay = 0.65

var owner_sprite = null

func init(owner_sprite):
	self.owner_sprite = owner_sprite

func add_command(command: String):
	self.commands.push_back({ "command": command, "delay": delay })
