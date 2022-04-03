tool
extends Button

var sound_effect_player

export (AudioStream) var sound_effect_stream
export (float) var sound_effect_volume_db = 0.0 setget set_sound_effect_volume_db

func _ready():
	var stream_player = AudioStreamPlayer.new()
	stream_player.stream = sound_effect_stream
	stream_player.volume_db = sound_effect_volume_db
	stream_player.add_to_group("sound_effect_player")
	self.add_child(stream_player)
	self.sound_effect_player = stream_player
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	self.connect("pressed", self, "clicked")
	
func clicked():
	self.sound_effect_player.play()

func set_sound_effect_stream(val):
	if self.sound_effect_player == null:
		return
	sound_effect_stream = val
	self.sound_effect_player.stream = val

func set_sound_effect_volume_db(val):
	if self.sound_effect_player == null:
		return
	sound_effect_volume_db = val
	self.sound_effect_player.volume_db = val
