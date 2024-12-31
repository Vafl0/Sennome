class_name Queue extends Resource

@export var curr: Array[Tagged] = []
var progress := 0.0

func enqueue(act: Tagged) -> void:
	curr.push_back(act)
func clear() -> void:
	curr = []

class ActionHandler extends Resource:
	var get_time
	var do
	func _init(get_time, do) -> void:
		self.get_time = get_time
		self.do = do

func next_act() -> void:
	curr.pop_front()
	progress = 0.0

func run(hdls: Dictionary) -> void:
	if curr.size() == 0:
		return
	var hdl = hdls[curr[0].tag]
	if hdl == null:
		next_act()
		return run(hdls)
	
	var act_time : int = hdl.get_time.call(curr[0].val)
	progress += 1/float(act_time)
	if progress > 0.999:
		hdl.do.call(curr[0].val)
		next_act()
