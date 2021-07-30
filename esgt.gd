extends Node

var scene_path

var time_transition = 2
onready var scene_node = get_tree().get_current_scene()

var transition_kind = "fade"

var transition_kinds = ["fade","left-to-right","right-to-left","up-to-down","down-to-up"]

var color_transition = Color.black
var transtion_to = Color(0,0,0,0)

var is_img=false


var vp:Vector2

var change_scene = false

var tween:Tween
var rect
var rect_col:ColorRect
var rect_img:TextureRect
var z_index:CanvasLayer

var trk = {
	"fade": {
		"in":[Color.black, Color(0,0,0,0)],
		"out":[Color(0,0,0,0),Color.black]
	},
	"ltr": {
		"in":[Vector2(0-vp.x,0), Vector2(0,0)],
		"out":[Vector2(vp.x,0), Vector2(0,0)]
	}	
}

func set_transition_time(time:float):
	time_transition=time

func set_transition(trs):
	if transition_kinds.has(trs):
		transition_kind=trs

func set_image(img):
	rect_img.texture=img
	is_img=true
	rect = rect_img

func set_transion_time(time):
	time_transition = time

func change_color(color=color_transition):
	is_img=false
	color_transition=color
	rect.color=color_transition
	transtion_to = color
	transtion_to.a=0
	
func _ready():
	vp = get_viewport().size
	get_tree().connect("node_added",self,"exit_scene")
	tween = Tween.new()
	add_child(tween)
	tween.connect("tween_completed",self,"change")
	z_index = CanvasLayer.new()
	z_index.layer=124
	rect_img = TextureRect.new()
	rect_img.expand=true
	rect_img.rect_size  = vp
	rect_col = ColorRect.new()
	rect_col.color= color_transition
	rect_col.rect_size  = vp
	z_index.add_child(rect_img)
	z_index.add_child(rect_col)
	add_child(z_index)
	if is_img:
		rect = rect_img
		rect_col.hide()
	else:
		rect = rect_col	
		rect_img.hide()
		rect_col.hide()
#	create()
	
	
func create():
	transition_in(time_transition,transition_kind)
	
func exit_scene(node):
	if node == get_tree().get_current_scene():
		create()
	
func change_scene(scene,duration=time_transition,kind=transition_kind):
	change_scene=true
	scene_path = scene
	transition_out(duration,kind)
	
func transition_out(duration,kind):
	duration=duration/2
	match(kind):
		"fade":
			rect_re()
			var from = Color.white
			var to = from
			from.a=0
			tween.interpolate_property(rect,"modulate",from,to,duration)
			tween.start()
		"left-to-right":
			rect_re()
			var from = Vector2(vp.x,0)
			var to = Vector2(0,0)
			tween.interpolate_property(rect,"rect_position",from,to,duration)
		"right-to-left":
			var from = Vector2(vp.x,0)
			var to = Vector2(0,0)
			rect_re()
			tween.interpolate_property(rect,"rect_position",from,to,duration)	
		"up-to-down":
			var from = Vector2(0,0-vp.y)
			var to = Vector2(0,0)
			rect_re()
			tween.interpolate_property(rect,"rect_position",from,to,duration)
		"down-to-up":
			var from = Vector2(0,vp.y)
			var to = Vector2(0,0)
			rect_re()
			tween.interpolate_property(rect,"rect_position",from,to,duration)		
		"default":
			pass
	tween.start()	
	
func transition_in(duration,kind):
	duration=duration/2
	match(kind):
		"fade":
			rect_re()
			var from = Color.white
			var to = from
			to.a=0
			tween.interpolate_property(rect,"modulate",from,to,duration)
			tween.start()
		"left-to-right":
			var from = Vector2(0,0)
			var to = Vector2(0-vp.x,0)
			rect_re()
			tween.interpolate_property(rect,"rect_position",from,to,duration)
		"right-to-left":
			var from = Vector2(0,0)
			var to = Vector2(0-vp.x,0)
			rect_re()
			tween.interpolate_property(rect,"rect_position",from,to,duration)	
		"up-to-down":
			var from = Vector2(0,0)
			var to = Vector2(0,vp.y)
			rect_re()
			tween.interpolate_property(rect,"rect_position",from,to,duration)
		"down-to-up":
			var from = Vector2(0,0)
			var to = Vector2(0,0-vp.y)
			rect_re()
			tween.interpolate_property(rect,"rect_position",from,to,duration)	
		"default":
			pass
	tween.start()
		
func rect_re():
	rect.show()
	
func rect_hide():
	rect.hide()
		
func change(object,key):
	if change_scene:
		change_scene=false
		get_tree().change_scene(scene_path)
	else:
		rect_hide()
		
