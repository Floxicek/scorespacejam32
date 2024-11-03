extends CanvasLayer

func _ready():
	$StrokeCount.text = str(0)
	Score.update_strokes.connect(update_strokes)
	#show_scoreboard()

func update_strokes(new_stroke):
	$StrokeCount.text = str(new_stroke)
	

func show_scoreboard():
	$Scoreboard.show_me()

func _on_timer_timeout():
	show_scoreboard()
