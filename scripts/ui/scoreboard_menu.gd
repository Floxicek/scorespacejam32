extends Control

var scoreboards

@export var scoreboardLabel : PackedScene = preload("res://scenes/prefabs/scoreboardLabel.tscn")
@export var level := 1

@export var scoreboard:Control
@export var loading:Control
@export var vbox:Control
@export var autostart := false

func _ready():
	hide()
	scoreboard.text = "SCOREBOARD HARD" if level == 2  else "SCOREBOARD EASY"
	if autostart:
		show_scoreboard()


func show_scoreboard():
	var sw_result = await SilentWolf.Scores.get_scores(200, "level"+str(level)).sw_get_scores_complete
	print(level, sw_result)
	loading.hide()
	var scoreboards = sw_result.scores
	print("Scores: " + str(sw_result.scores))
	if scoreboards.size() != 0:
		show()
	
	for i in scoreboards:
		var lab = scoreboardLabel.instantiate()
		lab.text = str(i["player_name"]) + " " + str(Score.read_score_from_leaderboard(i["score"]))
		vbox.add_child(lab)
