extends KinematicBody2D

var rock = preload("res://scenes/Rock.tscn")

var speed = 1000
var velocity = Vector2()

var level #this will speed up the timer based on what "level" the user is on.
onready var timer_time = $Timer.wait_time

var corner1 = Vector2(-200,-200)
var corner2 = Vector2(1480,-200)
var corner3 = Vector2(1480,920)
var corner4 = Vector2(-200,920)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = corner1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.x < -200:
		global_position.x = -200
	if global_position.y < -200:
		global_position.y = -200
	if global_position.x > 1480:
		global_position.x = 1480
	if global_position.y > 920:
		global_position.y = 920
	
	if global_position == corner1:
		velocity = Vector2(speed, 0)
	if global_position == corner2:
		velocity = Vector2(0, speed)
	if global_position == corner3:
		velocity = Vector2(-speed, 0)
	if global_position == corner4:
		velocity = Vector2(0, -speed)
	
	move_and_slide(velocity)
	
	level = WorldVars.score / 1000
	$Timer.wait_time = timer_time - level
	

func _on_Timer_timeout() -> void:
	shoot()

func shoot():
	var r = rock.instance()
	look_at(WorldVars.get_ship_position())
	r.start(global_position, rotation)
	get_parent().add_child(r)
