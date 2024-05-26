extends VBoxContainer
var Winner;
var Winner_score;
var Second;
var Second_score;
var Third;
var Third_score;
var Fourth;
var Fourth_score;
# Called when the node enters the scene tree for the first time.
func _ready():
	Winner=Global.player_1_name;
	Winner_score=Global.player_1_score;
	if Global.player_2_score>Winner_score:
		Second=Winner;
		Second_score=Winner_score;
		Winner=Global.player_2_name;
		Winner_score=Global.player_3_score;
	else:
		Second=Global.player_2_name;
		Second_score=Global.player_2_score;
	if Global.player_3_score>Winner_score:
		Third=Second;
		Third_score=Second_score;
		Second=Winner;
		Second_score=Winner_score;
		Winner=Global.player_3_name;
		Winner_score=Global.player_2_score;
	else:
		if Global.player_3_score>Second_score:
			Third=Second;
			Third_score=Second_score;
			Second=Global.player_2_name;
			Second_score=Global.player_3_score;
		else:
			Third=Global.player_3_name;
			Third_score=Global.player_3_score;
	if Global.player_4_score>Winner_score:
		Fourth=Third;
		Fourth_score=Third_score;
		Third=Second;
		Third_score=Second_score;
		Second=Winner;
		Second_score=Winner_score;
		Winner=Global.player_4_name;
		Winner_score=Global.player_4_score;
	else:
		if Global.player_4_score>Second_score:
			Fourth=Third;
			Fourth_score=Third_score;
			Third=Second;
			Third_score=Second_score;
			Second=Global.player_4_name;
			Second_score=Global.player_4_score;
		else:
			if Global.player_4_score>Third_score:
				Fourth=Third;
				Fourth_score=Third_score;
				Third=Global.player_4_name;
				Third_score=Global.player_4_score;
			else:
				Fourth=Global.player_4_name;
				Fourth_score=Global.player_4_score;
	Global.First=Winner+"-------"+str(Winner_score);
	Global.Second=Second+":-------"+str(Second_score);
	Global.Third=Third+":-------"+str(Third_score);
	Global.Fourth=Fourth+":-------"+str(Fourth_score);

