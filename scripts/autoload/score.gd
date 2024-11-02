extends Node

var last_score = 0
var highscore = 0

const MAX_SCORE = 1000000

func get_score_for_leaderboard():
	if last_score >= MAX_SCORE:
		return -1
	return MAX_SCORE - last_score

func read_score_from_leaderboard(score):
	return MAX_SCORE - score

func new_score(sc):
	last_score = sc
	if highscore < last_score:
		highscore = last_score