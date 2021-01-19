extends KinematicBody2D



var bullet = preload("res://scenes/Bullet.tscn")

export (int) var speed = 200
export (float) var rotation_speed = 5

var velocity = Vector2()
var rotation_dir = 0

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		rotation_dir += 1
	if Input.is_action_pressed('left'):
		rotation_dir -= 1
	if Input.is_action_pressed('down'):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed('up'):
		velocity = Vector2(speed, 0).rotated(rotation)

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	WorldVars.emit_signal("ship_position", position)

func shoot():
	var b = bullet.instance()
	b.start($Position2D.global_position, rotation)
	get_parent().add_child(b)

func hit():
	WorldVars.emit_signal("game_over")
	queue_free()