extends Node

signal cell_changed(from,to)

signal about_to_act(delta)
signal acted(action)

signal kill(me)

export(String) var thing_name = "Thing"
export(String) var desctription = "It's a Thing"
export(Texture) var default_pawn_texture = preload("res://assets/graphics/ui/pot.png")

export(bool) var blocks_movement = false setget _set_blocks_movement
export(bool) var blocks_sight = false setget _set_blocks_sight
export(bool) var stay_visibal = false

var found = false

var cell = Vector2() setget _set_cell

var SID = -1
var database_path

var pawn = null

var in_inventory = false

# Component refs
var fighter
var item
var equipment
var ai

func setup():
	connect("about_to_act", self, "_rpg_process")
	add_to_group("things")
	if blocks_movement:
		add_to_group("blockers")
	if blocks_sight:
		add_to_group("sightblockers")
	
	for node in get_children():
		if node.has_method("setup"):
			node.setup()

func _rpg_process(delta):
	if ai :
		ai.act(delta)
	
func _set_blocks_movement(what):
	blocks_movement = what
	if blocks_movement:
		if !is_in_group("blockers"):
			add_to_group("blockers")
	else:
		if is_in_group("blockers"):
				remove_from_group("blockers")

func _set_blocks_sight( what ):
	blocks_sight = what
	if blocks_sight:
		if !is_in_group("sightblockers"):
			add_to_group("sightblockers")
	else:
		if is_in_group("sightblockers"):
			remove_from_group("sightblockers")

func _set_cell( what ):
	emit_signal( "cell_changed",cell,what)
	cell = what
	
func _on_fighter_died():
	emit_signal("kill",self)
			
