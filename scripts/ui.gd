extends CanvasLayer

func _ready():
	$StrokeCount.text = str(0)
	Score.update_strokes.connect(update_strokes)

func update_strokes(new_stroke):
	$StrokeCount.text = str(new_stroke)
	
