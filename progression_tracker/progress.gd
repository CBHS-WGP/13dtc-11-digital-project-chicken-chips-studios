extends Node
#Begin with a reset objective
var current_objective = 0
# Objective 1 to 1.99 varibles
var Sattelite_Discovered = false
var Parts_Discovered = 0
#When this turns true, spawn enemies, then move to 2.1 so they dont spawn every frame.
var Sattelite_repaired = false

# Objective 2 to 2.99 varibles
var weapons_cache_found = false
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

#Go from here!
# Spawn in enemies, and start new communications up, now move to objective 2.1.
# Upon location of the weapons cache, get lots of ammo and the G32 + move to objective 2.5
# Now killing spree. Once all located enemies are dead, move to objective 3
# Locate the impact site, move to objective 3.5 as you kill random protecting enemies.
# Dungeon like gameplay 
# Finding the boss room sets game to objective 4.
#Killing the boss ends the game


func _process(_delta):
	#print(Progress.current_objective)
	#Progressing past objective 1 (killing 5 enemies)
	#if Progress.objective_1 >= 5:
	#	current_objective = current_objective + 1
	#if Progress.current_objective == 1:
	#	pass
	#If objective 3, win the game
	#if Progress.current_objective == 3:
	#	get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		
	#Player death
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Charlie/UI/credits.tscn")
		print("You reached objective " + Progress.current_objective)
		
