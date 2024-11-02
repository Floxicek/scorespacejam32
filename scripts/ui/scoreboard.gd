extends Control

var scoreboards

func _ready():
	#SilentWolf.Scores.wipe_leaderboard()
	$Scoreboard.hide()
	$UsernameInput.hide()

	$UsernameInput.show()


func _on_username_cancel_button_pressed():
	show_scoreboard()


func _on_username_sumbit_button_pressed():
	if not %Username.text:
		return
	var sc = Score.get_score_for_leaderboard()
	if not sc == -1:
		await SilentWolf.Scores.save_score(%Username.text, sc)
	show_scoreboard()


func show_scoreboard():
	$UsernameInput.hide()
	$Scoreboard.show()
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	scoreboards = sw_result.scores
	print("Scores: " + str(sw_result.scores))
	
	
	for i in scoreboards:
		var lab = Label.new()
		lab.text = str(i["player_name"]) + " " + str(i["score"])
		%ScoreboardVBox.add_child(lab)
