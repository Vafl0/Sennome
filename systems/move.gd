class_name Move extends Resource

@export var pos := Vector2i(0, 0)

func path_to(to: Vector2i) -> Array[Variant]:
	var curr_pos := pos
	var rstep : Array[Vector2i] = []
	var rpos : Array[Vector2i] = []
	while to != curr_pos:
		var step := (to - curr_pos).clampi(-1, 1)
		curr_pos += step
		rstep.push_back(step)
		rpos.push_back(curr_pos)
	return [rstep, rpos]

func draw_path(path_marker: TileMapLayer) -> void:
	var waypoints : Array[Vector2i] = path_to(path_marker.local_to_map(
		path_marker.get_local_mouse_position()))[1]
	path_marker.clear()
	for waypoint in waypoints:
		path_marker.set_cell(waypoint, 0, Vector2i(0, 0))

func enqueue_move_to_click(world: TileMapLayer, queue: Queue) -> void:
	var steps : Array[Vector2i] = path_to(world.local_to_map(
		world.get_local_mouse_position()))[0]
	queue.clear()
	for step in steps:
		queue.enqueue(Tagged.new(Game.ACT.STEP, step))

func step_hdl(entity: Node2D, world: TileMapLayer) -> Queue.ActionHandler:
	return Queue.ActionHandler.new(
		func(step: Vector2i):
			return round(step.length() * 2),
		func(step: Vector2i):
			pos += step
			entity.position = world.map_to_local(pos))
