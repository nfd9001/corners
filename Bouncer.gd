extends KinematicBody2D
class_name Bouncer

signal inc_corner
var direction = Vector2.ZERO
var random = RandomNumberGenerator.new()
export(float, 0.0, 1.0, 0.01) var wiggleSeverity = 0.02
export(float, 0.0, 200.0, 0.5) var velocity = 10
var cornerTimer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	direction = randAngle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func randAngle():
	return Vector2(random.randfn(), random.randfn()).normalized()
	
func wiggleDirection():
	var newangle = randAngle()
	direction = direction.slerp(newangle, wiggleSeverity)
	
func _physics_process(delta):
	var coll_info = move_and_collide(velocity * direction * delta)
	if coll_info:
		var isCorner = coll_info.collider.get_meta("corner")
		if isCorner:
			emit_signal("inc_corner")
			set_collision_mask_bit(1, false)
			cornerTimer = 5
			move_and_collide(velocity * direction * delta)
			return
		direction = direction.bounce(coll_info.normal)
		wiggleDirection()
		if cornerTimer > 1:
			cornerTimer -= 1
		if cornerTimer == 1:
			cornerTimer -= 1
			set_collision_mask_bit(1, true)
		
	move_and_collide(velocity * direction * delta)

