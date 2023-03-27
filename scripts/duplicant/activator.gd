extends "res://scripts/duplicant.gd"

func activate():
	if Globals.signals[self] != null:
		Globals.signals[self].activators += 1

func deactivate():
	if Globals.signals[self] != null:
		Globals.signals[self].activators -= 1
