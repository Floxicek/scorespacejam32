extends Control

var scoreboards

@export var scoreboardLabel : PackedScene = preload("res://scenes/prefabs/scoreboardLabel.tscn")

func _ready():
	#SilentWolf.Scores.wipe_leaderboard()
	$Scoreboard.hide()
	$UsernameInput.hide()

func show_me():
	if SceneManager.current_level != 0:
		if Score.username == "":
			$UsernameInput.show()
		else:
			submit_score()
			show_scoreboard()
	else:
		SceneManager.menu()

func _on_username_cancel_button_pressed():
	show_scoreboard()

func _on_username_sumbit_button_pressed():
	if not %Username.text:
		return
	Score.username = %Username.text
	submit_score()
	show_scoreboard()

func submit_score():
		var sc = Score.get_score_for_leaderboard()
		if not sc == -1:
			var sw_result: Dictionary = await SilentWolf.Scores.save_score(Score.username, sc, "level"+str(SceneManager.current_level)).sw_save_score_complete
			print("Score persisted successfully: " + str(sw_result.score_id))

func show_scoreboard():
	print("Showing scoreboard")
	if SceneManager.current_level == 0:
		_on_continue_pressed()
		return
	$UsernameInput.hide()
	$Scoreboard.show()
	await get_tree().create_timer(.5).timeout
	var sw_result = await SilentWolf.Scores.get_scores(200, "level"+str(SceneManager.current_level)).sw_get_scores_complete
	%LOADING.hide()
	var scoreboards = sw_result.scores
	print("Scores: " + str(sw_result.scores))
	
	for i in scoreboards:
		var lab = scoreboardLabel.instantiate()
		lab.text = str(i["player_name"]) + " " + str(Score.read_score_from_leaderboard(i["score"]))
		%ScoreboardVBox.add_child(lab)


func _on_continue_pressed():
	$Scoreboard.hide()
	$UsernameInput.hide()
	for c in %ScoreboardVBox.get_children():
		if not (c.name == "Scoreboard" or c.name == "LOADING"):
			c.queue_free()
	SceneManager.menu()
	%LOADING.show()
