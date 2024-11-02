extends CanvasLayer

var stroke_count = 0
func _ready():
	$StrokeCount.text = str(stroke_count)


func add_stroke():
	stroke_count += 1
	$StrokeCount.text = str(stroke_count)
