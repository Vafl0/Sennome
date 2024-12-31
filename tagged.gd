class_name Tagged extends Resource

@export var tag: int
@export var val: Variant = null

func _init(p_tag, p_val):
	tag = p_tag
	val = p_val
