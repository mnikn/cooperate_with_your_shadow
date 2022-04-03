extends "res://src/sprites/BaseSprite.gd"


var footstep_effect = preload("res://assets/audio/footstep.ogg")
var jump_effect = preload("res://assets/audio/jump.ogg")
var jump_falldown_effect = preload("res://assets/audio/jump_falldown.ogg")

var run_smoke_scene = preload("res://src/sprites/RunSmoke.tscn")
var jump_smoke_scene = preload("res://src/sprites/JumpSmoke.tscn")
var run_smoke
var run_smoke_dismiss_timer

func _ready():
	footstep_effect.loop = false
	jump_effect.loop = false
	jump_falldown_effect.loop = false
	$Sprite.modulate = Color("#fff")

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
	
	if $Sprite.animation == "idle" and self.run_smoke != null and self.run_smoke_dismiss_timer == null:
		self.run_smoke.frame = 35
		self.run_smoke_dismiss_timer = self.get_tree().create_timer(0.2)
		run_smoke_dismiss_timer.connect("timeout", self, "remove_run_smoke")

func add_command(command: String):
	if command == "player_jump":
		if self.run_smoke != null and self.run_smoke_dismiss_timer == null:
			self.remove_run_smoke()
			
		if self.is_on_floor():
			var node = self.jump_smoke_scene.instance()
			node.play("brust")
			var modify = Vector2.ZERO
			if Input.is_action_pressed("player_left"):
				modify.x -= 15
				modify.y -= 45
				node.rotation_degrees = 290
			elif Input.is_action_pressed("player_right"):
				modify.x = 15
				modify.y -= 45
				node.rotation_degrees = 70
			node.global_position = Vector2(self.global_position.x + modify.x, self.global_position.y + 50 + modify.y) 
			node.connect("animation_finished", self, "remove_node", [node])
			self.get_parent().add_child(node)
	
	if command == "player_right" or command == "player_left":
		if self.run_smoke == null and self.is_on_floor():
			self.run_smoke = self.run_smoke_scene.instance()
			self.run_smoke.position = Vector2(-40, 13)
			self.add_child(self.run_smoke)
			self.run_smoke.play("brust")
		if self.run_smoke != null:
			if command == "player_right":
				self.run_smoke.position = Vector2(-40, 13)
				self.run_smoke.flip_h = false
			elif command == "player_left":
				self.run_smoke.position = Vector2(40, 13)
				self.run_smoke.flip_h = true
	.add_command(command)


func remove_run_smoke():
	if self.run_smoke == null:
		return
	self.run_smoke.queue_free()
	self.run_smoke = null
	self.run_smoke_dismiss_timer = null

func remove_node(node):
	if node == null:
		return
	node.queue_free()

func dead():
	self.enabled = false
	$AnimationPlayer.play("dead")
	yield($AnimationPlayer, "animation_finished")
