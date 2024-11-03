extends Control

var scoreboards
var username = "Testicek"

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
	username = %Username.text
	var sc = Score.get_score_for_leaderboard()
	if not sc == -1:
		
		var sw_result: Dictionary = await SilentWolf.Scores.save_score(%Username.text, sc, "level0").sw_save_score_complete
		print("Score persisted successfully: " + str(sw_result.score_id))
	show_me()

func show_scoreboard():
	print("Showing scoreboard")
	if SceneManager.current_level == 0:
		_on_continue_pressed()
		return
	$UsernameInput.hide()
	$Scoreboard.show()
	await get_tree().create_timer(3).timeout
	var sw_result = await SilentWolf.Scores.get_scores(200, "level"+str(SceneManager.current_level)).sw_get_scores_complete
	var scoreboards = sw_result.scores
	print("Scores: " + str(sw_result.scores))
	
	for i in scoreboards:
		var lab = Label.new()
		lab.text = str(i["player_name"]) + " " + str(Score.read_score_from_leaderboard(i["score"]))
		%ScoreboardVBox.add_child(lab)


func _on_continue_pressed():
	$Scoreboard.hide()
	$UsernameInput.hide()
	for c in %ScoreboardVBox.get_children():
		if not c.name == "Scoreboard":
			c.queue_free()
	SceneManager.new_scene(1)
