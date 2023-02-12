extends KinematicBody2D

var velocity = Vector2.ZERO
var small_speed = 3.0
var initial_speed = 3.0
var health = 1

onready var Asteroid_small = load("res://Asteroid/Asteroid_small.tscn")
onready var Asteroid_small2 = load("res://Asteroid/Asteroid_small2.tscn")
var small_asteroids = [Vector2(0,-30),Vector2(30,30),Vector2(-30,30)]

func _ready():
	velocity = Vector2(0,initial_speed*randf()).rotated(PI*2*randf())

func _physics_process(_delta):
	position = position + velocity
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)


func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(50)
		collision_layer = 0
		var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
		if Asteroid_Container != null:
			for s in small_asteroids:
				var asteroid_small = Asteroid_small.instance()
				var asteroid_small2 = Asteroid_small2.instance()
				var dir = randf()*2*PI
				var i = Vector2(0,randf()*small_speed).rotated(dir)
				var type = randf()
				if type < 0.5:
					Asteroid_Container.call_deferred("add_child", asteroid_small)
					asteroid_small.position = position + s.rotated(dir)
					asteroid_small.velocity = i
				else: 
					Asteroid_Container.call_deferred("add_child", asteroid_small2)
					asteroid_small2.position = position + s.rotated(dir)
					asteroid_small2.velocity = i
		queue_free()
