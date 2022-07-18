extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(count)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bouncer_inc_corner():
	count += 1
	text = str(count)
