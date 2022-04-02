extends KinematicBody2D

export var move_speed = 320.0

var velocity := Vector2.ZERO

export var jump_height : float = 100
export var jump_time_to_peak : float = 0.4
export var jump_time_to_descent : float = 0.3

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var enabled = true

# store commands, thus we can use it for delay
var commands = []

func _physics_process(delta):
	if Input.is_action_pressed("player_left"):
		self.add_command("player_left")
	if Input.is_action_pressed("player_right"):
		self.add_command("player_right")
	if Input.is_action_just_pressed("player_jump"):
		self.add_command("player_jump")
	if not self.enabled:
		self.commands = []
		
	# cal need delay time
	for action in self.commands:
		action.delay = max(action.delay - delta, 0)
	self.do_move(delta)
	
	var new_actions = []
	for action in self.commands:
		if action.delay != 0:
			new_actions.push_back(action)
	self.commands = new_actions

func do_move(delta):
	velocity.y += get_gravity() * delta
	velocity.x = get_input_velocity() * move_speed
	
	if is_on_floor():
		if velocity.x == 0:
			$Sprite.play("idle")
		else:
			$Sprite.play("run")
	
	var action_jump = self.find_action("player_jump")
	if action_jump != null and is_on_floor():
#		$Sprite.play("jump_prepare")
		jump()
	
	if velocity.y < 0:
		$Sprite.play("jump_floating")
		
	if velocity.y >= 0 and not is_on_floor():
		$Sprite.play("jump_falldown")
	
	if velocity.x < 0:
		$Sprite.flip_h = true
	elif velocity.x > 0:
		$Sprite.flip_h = false
		
	velocity = move_and_slide(velocity, Vector2.UP)

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity

func get_input_velocity() -> float:
	var horizontal := 0.0

	var left_action = self.find_action("player_left")
	if left_action != null:
		horizontal -= 1.0
	var right_action = self.find_action("player_right")
	
	if right_action != null:
		horizontal += 1.0
	
	return horizontal

func find_action(command):
	var action = ArrayUtils.find(self.commands,  { "command": command })
	return action if (action != null and action.delay <= 0) else null

func add_command(command):
	self.commands.push_back({ "command": command, "delay": 0 })
