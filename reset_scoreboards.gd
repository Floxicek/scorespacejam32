extends Node

func _ready():
	SilentWolf.Scores.wipe_leaderboard()
	SilentWolf.Scores.wipe_leaderboard("level1")
	SilentWolf.Scores.wipe_leaderboard("level2")
