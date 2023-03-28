extends Node

# Put some global variables in here
# You can access the variables anywhere at anytime throughout the program
# For example, you could do Globals.muted to access that

var muted = true
var signals = {}
var cam_delta: Vector2

# TOOD: update this for each new level someone adds
var levelsCount = 9

# Note this will be 1 behind the name of the scene because levels start at one there
var levelPlayerIsOn = 0
var thisLevels

func _init():
	thisLevels = LevelsInfo.new(levelsCount)

var prevTime
var prevWarps

class LevelInfo:
	# Time to complete level in seconds
	var timeToComplete =999
	var levelCompleted = false
	var warps = 999
	
	var levelNumber
	var name
	
	func _init(levelNumber, name="Level " + str(levelNumber + 1)):
		self.name = name
		self.levelNumber = levelNumber

class LevelsInfo:
	var levelsCount;
	var levelArray;
	
	func _init(levelsCount):
		self.levelsCount = levelsCount
		levelArray = []
		
		for i in levelsCount:
			levelArray.append(LevelInfo.new(i))
	
	func getCurrentLevel():
		return levelArray[Globals.levelPlayerIsOn]
	
	func endLevelCheck(warps, timeToComplete):
		Globals.prevWarps = warps
		Globals.prevTime  = timeToComplete
		
		# If any records are broken or anything else is needed to be updated, update this
		levelArray[Globals.levelPlayerIsOn].levelCompleted = true
		
		if(warps < levelArray[Globals.levelPlayerIsOn].warps):
			levelArray[Globals.levelPlayerIsOn].warps = warps
		
		if(timeToComplete < levelArray[Globals.levelPlayerIsOn].timeToComplete):
			levelArray[Globals.levelPlayerIsOn].timeToComplete = timeToComplete
