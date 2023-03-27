extends "res://scripts/duplicant.gd"

func activate():
ww	if Globals.signals[self] != null:
		Globals.signals[self].activators += 1

func deactivate():
	if Globals.signals[self] != null:
		Globals.signals[self].activators -= 1
