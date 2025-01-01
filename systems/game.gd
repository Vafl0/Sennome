class_name Game extends Node2D

@export var world : TileMapLayer
@export var entity : Node2D
@export var path_marker : TileMapLayer

@export var queue : Queue = Queue.new()
@export var move : Move = Move.new()

@export var tick_duration: float

enum ACT {STEP}

func _on_world_area_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		move.enqueue_move_to_click(world, queue)

var timer := 0.0

func _process(delta: float) -> void:
	move.draw_path(path_marker)
	
	timer += delta
	while timer >= tick_duration:
		timer -= tick_duration
		tick()

func tick() -> void:
	queue.run({ ACT.STEP: move.step_hdl(entity, world) })
