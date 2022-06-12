/obj/effect/spawner/structure/window/reinforced
	name = "reinforced window spawner"
	icon_state = "rwindow_spawner"
	spawn_list = list(/obj/structure/grille/window, /obj/structure/window/reinforced/fulltile, /turf/open/floor/low_wall/reinforced)

/obj/effect/spawner/structure/window
	icon = 'icons/obj/structures_spawners.dmi'
	icon_state = "window_spawner"
	name = "window spawner"
	spawn_list = list(/obj/structure/grille/window, /obj/structure/window/fulltile, /turf/open/floor/low_wall)
	dir = SOUTH
