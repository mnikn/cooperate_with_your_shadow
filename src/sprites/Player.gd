extends "res://src/sprites/BaseSprite.gd"


var footstep_effect = preload("res://assets/audio/footstep.ogg")
var jump_effect = preload("res://assets/audio/jump.ogg")
var jump_falldown_effect = preload("res://assets/audio/jump_falldown.ogg")

func _ready():
	footstep_effect.loop = false
	jump_effect.loop = false
	jump_falldown_effect.loop = false

func _physics_process(delta):
	if self.is_on_floor() and $SoundEffectPlayer.stream == jump_effect:
		if $SoundEffectPlayer.stream != jump_falldown_effect:
			$SoundEffectPlayer.stream = jump_falldown_effect
		if not $SoundEffectPlayer.playing:
			$SoundEffectPlayer.play()
	if self.velocity.y < 0:
		if $SoundEffectPlayer.stream != jump_effect:
			$SoundEffectPlayer.stream = jump_effect
		if not $SoundEffectPlayer.playing:
			$SoundEffectPlayer.play()
	if self.is_on_floor() and self.velocity.x != 0:
		if $SoundEffectPlayer.stream != footstep_effect:
			$SoundEffectPlayer.stream = footstep_effect
		if not $SoundEffectPlayer.playing:
			$SoundEffectPlayer.play()
