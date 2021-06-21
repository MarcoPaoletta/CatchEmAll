extends Control

func update_timer(new_val):
	$MarginContainer/TimerL.text = str(new_val)

func update_score(new_val):
	$MarginContainer/ScoreL.text = str(new_val)
