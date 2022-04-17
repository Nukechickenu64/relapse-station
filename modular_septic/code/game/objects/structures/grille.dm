/obj/structure/grille
	icon = 'modular_septic/icons/obj/structures/structures.dmi'

/obj/structure/grille/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_brittle, "fireaxe")
