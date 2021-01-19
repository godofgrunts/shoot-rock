extends Label

func _ready() -> void:
	self.hide()
	WorldVars.connect("game_over", self, "_on_game_over")

func _on_game_over():
	self.show()
