extends Control

var scoreboards
var username = ""

func _ready():
	#SilentWolf.Scores.wipe_leaderboard()
	$Scoreboard.hide()
	$UsernameInput.hide()

func show_me():
	if not username:
		$UsernameInput.show()
	else:
		show_scoreboard()

func _on_username_cancel_button_pressed():
	show_scoreboard()

func _on_username_sumbit_button_pressed():
	if not %Username.text:
		return
	var sc = Score.get_score_for_leaderboard()
	if not sc == -1:
		await SilentWolf.Scores.save_score(%Username.text, sc)
	show_me()

func show_scoreboard():
	$UsernameInput.hide()
	$Scoreboard.show()
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	scoreboards = sw_result.scores
	print("Scores: " + str(sw_result.scores))
	
	for i in scoreboards:
		var lab = Label.new()
		lab.text = str(i["player_name"]) + " " + str(Score.read_score_from_leaderboard(i["score"]))
		%ScoreboardVBox.add_child(lab)
