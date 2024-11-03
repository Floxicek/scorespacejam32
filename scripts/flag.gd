extends Area2D

@export var ui: Control

func _ready():
	Score.start_game()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Winnniiing")
		# Play win animation
		# Maybe show some fireworks...
		# End score
		Score.level_finished()
		$Timer.start()
		$CPUParticles2D.restart()

func _on_timer_timeout():
	ui.show_scoreboard()
