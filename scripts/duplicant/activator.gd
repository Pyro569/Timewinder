extends "res://scripts/duplicant.gd"

func activate():
	Globals.signals[self].activators += 1

func deactivate():
	Globals.signals[self].activators -= 1
