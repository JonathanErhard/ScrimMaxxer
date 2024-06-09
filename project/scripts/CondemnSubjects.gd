extends TextEdit

var dict

var persistFile = "res://death.note"

func _saveDictData():
	var file = FileAccess.open(persistFile, FileAccess.WRITE)
	file.store_line(JSON.stringify(dict))

func _read_dict():
	dict = JSON.parse_string(FileAccess.open("res://death.note", FileAccess.READ).get_as_text())
	if dict == null:
		dict = {}
	
func _condemnSubjects():
	_read_dict()
	for line in self.text.split("\n"):
		line = line.strip_edges(true,true)
		if line != "":
			dict[line] = 1
	_saveDictData()
	print(dict)
