/datum/map_generator/cave_generator/efn
	open_turf_types = list(/turf/open/floor/grass = 1)
	closed_turf_types = null


	mob_spawn_list = null
	flora_spawn_list = list(/obj/structure/flora/ash/leaf_shroom = 2 , /obj/structure/flora/ash/cap_shroom = 2 , /obj/structure/flora/ash/stem_shroom = 2 , /obj/structure/flora/ash/cacti = 1, /obj/structure/flora/ash/tall_shroom = 2, /obj/structure/flora/ash/seraka = 2)
	feature_spawn_list = null

	initial_closed_chance = 45
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3
