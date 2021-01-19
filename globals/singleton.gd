extends Node

signal ship_position
var ship_pos

signal points_awarded
var score = 0

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("ship_position", self, "_ship_position")
	connect("points_awarded", self, "_rock_destroyed")

func _ship_position(pos):
	ship_pos = pos

func get_ship_position():
	return ship_pos

func _rock_destroyed(points):
	score += points
