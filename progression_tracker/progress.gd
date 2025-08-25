extends Node
#Varible for the path to the enemy, plus a reference to where the sqawn node.  
@onready var enemy1 = preload("res://Charles Tracey - Project Manager/enemyalreadyfollowing.tscn")
var spawn
@onready var weapons_cache = preload("res://Charlie/Specific Objective files/Player_POI_Discovery_Areas/Weapons_Cache_Found.tscn")
var cache_spawn

#Begin with a reset objective
var current_objective = 0
# Objective 1 to 1.99 varibles
var Sattelite_Discovered = false
var Parts_Discovered = 0
#When this turns true, spawn enemies, then move to 2.1 so they dont spawn every frame.
var Sattelite_repaired = false

# Objective 2 to 2.99 varibles
var weapons_cache_found = false
var spawn_enemies_obj_2 = 10
var obj_2_enemies_killed = 0

#Objective 3 to 5 varibles
var impact_site_discovered = false
var boss_killed = false

var objective_1 = 0

#Objective level notes
# 0 equals just spawned in. This is where the intro and starting ambiance are built
#You start with the knife in your inventory/pick it up stright away.
# apon finding the sattelite, we reach objective 1
# now when interacting with the sattelite, we get 1.5, find the parts
# after finding and instering all ___ parts AND fixing the sattelite functions, move to objective 2
# Spawn in weapons cache, and start new communications up, now move to objective 2.1.
# Upon location of the weapons cache, get lots of ammo and the G32 + move + spawn in enemies to objective 2.5
# Now killing spree. Once all located enemies are dead, move to objective 3
# Locate the impact site, move to objective 3.5 as you kill random protecting enemies.
# Dungeon like gameplay 
# Finding the boss room sets game to objective 4.
#Killing the boss ends the game

func _process(_delta):
	if current_objective == 2:
		var instance = weapons_cache.instantiate()
		cache_spawn.add_child(instance)
		current_objective = 2.1
	if current_objective == 2.5:
			for i in spawn_enemies_obj_2:
				var instance2 = enemy1.instantiate()
				instance2.position.x = randf() * 4
				instance2.position.z = randf() * 4
				spawn.add_child(instance2)
				#print(i)
				#print(instance2.global_position)
			current_objective = 2.55
	if obj_2_enemies_killed >= 10 and current_objective == 2.6:
		current_objective = 3
	if current_objective == 4 and boss_killed == true:
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		
	#Player death
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		print("You reached objective ", current_objective)
		
