extends Node2D

var mouse_pos = Vector2()
var slowingRadius = 100
var MAX_STEER = 7
var MAX_SPEED = 1


var leader_destination = Vector2()
var leader_destination_norm = Vector2()
var leader_desired_velocity = Vector2()
var leader_distance = 1
var leader_steering = Vector2()
var leader_mass = 1

var LEADER_BEHIND_DIST = 50

#var leader_transform = Vector2()
#var follower_destination = Vector2()
#var follower_destination_norm = Vector2()
#var follower_desired_velocity = Vector2()
#var follower_distance = 1
#var follower_steering = Vector2()
#var follower_mass = 1



onready var leader = $leader
onready var soldiers = $soldiers
onready var positions = $positions
onready var NPC = preload("res://scenes/human/NPC/NPC_Area2D.tscn")


func _ready():
	leader.init(100,3,40,10)
	#leader.player_camera.make_current()
	for i in range(0,$positions.get_child_count()):
		var soldier = NPC.instance()
		soldier.init(100,3,40,10,leader)
		$soldiers.add_child(soldier)
		soldier.set_position($positions.get_child(i).position)
	#for soldier in soldiers.get_children():
		
	
	
func _physics_process(delta):
#	leader_control(delta)
	follower_control(delta)
	
	
#func leader_control(delta):
#	leader_seek(delta)

	
	
func follower_control(delta):
	for soldier in soldiers.get_children():
		soldier.follow_leader(delta)

		

func select_new_leader():
	pass
		

		#follower.velocity = desired_velocity.normalized() * follower.linear_speed

		#follower.position = behind
		
		
		
#if (distance < slowingRadius) {
#    // Inside the slowing area
#    desired_velocity = normalize(desired_velocity) * max_velocity * (distance / slowingRadius)
#} else {
#    // Outside the slowing area.
#    desired_velocity = normalize(desired_velocity) * max_velocity


#The truncate() function takes two values, a vector and a number ("max"), 
#and returns a vector that is in the same direction as the input vector, 
#but is no longer than "max". (If the input vector is already shorter than "max", 
#then the output vector is the same as the input vector.)













#func leader_seek(delta):
#	if Input.is_action_just_pressed('right_mouse_button'):
#		mouse_pos = get_global_mouse_position()
#	leader_destination = (mouse_pos - leader.global_position)
#	leader_destination_norm = leader_destination.normalized()
#	#set leader rotation
#	leader.rotation = Vector2(1,0).rotated(leader.rotation).linear_interpolate(leader_destination_norm,leader.rotation_speed*delta).angle()
#	leader_desired_velocity = leader_destination
#	leader_distance = leader_desired_velocity.length()
#	if leader_distance < slowingRadius: 	#this should be disabled if unit is charging enemy, don't want slowdown
#									#see tutorial on 'pursuit' on same website
#		leader_desired_velocity = leader_desired_velocity.normalized() * MAX_SPEED * (leader_distance / slowingRadius)
#	else:
#		leader_desired_velocity = leader_desired_velocity.normalized() * MAX_SPEED
#	leader_steering = leader_desired_velocity - leader.velocity
#	leader_steering = leader_steering.clamped(MAX_STEER)
#	leader_mass = 1
#	leader_steering = leader_steering / leader_mass
#	leader.velocity = (leader.velocity + leader_steering).clamped(MAX_SPEED)

	
	
#func follow_leader(follower,delta):
#
#	var leader_transform = leader.velocity * -1
#	leader_transform = leader_transform.normalized() * LEADER_BEHIND_DIST
#	var follower_destination = (leader.position - follower.position) + leader_transform
#	var follower_destination_norm = follower_destination.normalized()
#	#set follower rotation
#	follower.rotation = Vector2(1,0).rotated(follower.rotation).linear_interpolate(follower_destination_norm,follower.rotation_speed*delta).angle()
#
#	var follower_desired_velocity = follower_destination
#	var follower_distance = follower_desired_velocity.length()
#	if follower_distance < slowingRadius:
#		follower_desired_velocity = follower_desired_velocity.normalized() * MAX_SPEED * (follower_distance / slowingRadius)
#	else:
#		follower_desired_velocity = follower_desired_velocity.normalized() * MAX_SPEED
#
#	var follower_steering = follower_desired_velocity - follower.velocity
#	#print(follower_steering)
#	follower_steering = follower_steering.clamped(MAX_STEER)
#	var follower_mass = 1
#	follower_steering = follower_steering / follower_mass 	#mass
#	follower.velocity = (follower.velocity + follower_steering).clamped(MAX_SPEED)
