/obj/structure/closet/crate/grief
	name = "Grief Crate"

/obj/structure/closet/grief
	name = "Grief Crate"

/obj/structure/closet/grief/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/lootshoot(src)


/obj/structure/closet/crate/grief/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/lootshoot(src)
