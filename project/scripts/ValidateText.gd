extends TextEdit

enum ListState{
	TOXIC = 1,
	HAD_TOXIC_TEAM = 2,
	WHITELIST = -1
	}

var persistFile
var regex
var dict
var switch
var t

func _process(delta):
	if switch:
		t += delta
		if t>10.0:
			get_tree().change_scene_to_file("res://scenes/ascii_magic.tscn")

func _ready():
	dict = JSON.parse_string(FileAccess.open("res://death.note", FileAccess.READ).get_as_text())
	if dict == null:
		dict = {}
	switch = false
	t = 0
		
func _parse_text(discord_text:String):
	regex = RegEx.new()
	regex.compile("[^[\\s:,;()-]+#[0-9]*")
	var enemies_matches =  regex.search_all(discord_text)
	var enemies = []
	for enemie_match in enemies_matches:
		enemies.append(enemie_match.strings[0])
	print(enemies)
	return enemies

func _validate():
	print(dict)
	var enemies = _parse_text(self.text)
	var contains_idiots = false
	var output = "The High Court has searched extensivly for possible cringe behaviour of defendants:\n\n"
	for enemie in enemies:
		output += enemie + '\n'
	output += "\nand has found:\n\n"
	for i in range(enemies.size()):
		enemies[i] = enemies[i].strip_edges(true,true)
		if dict.has(enemies[i]):
			if dict[enemies[i]] == 1:
				output = output + enemies[i]+ " is blacklisted\n"
				contains_idiots = true
			else: if dict[enemies[i]] == ListState.HAD_TOXIC_TEAM:
				output = output + enemies[i] + " war in schlechter Gesellschaft\n"
				contains_idiots = true
			else: if dict[enemies[i]] == ListState.WHITELIST:
				pass
	if !contains_idiots:
		output += "nothing"
		self.text = output
		switch = true
	self.text = output
