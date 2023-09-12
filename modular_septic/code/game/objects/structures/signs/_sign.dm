/obj/structure/sign
	icon = 'modular_septic/icons/obj/decals.dmi'
	plane = ABOVE_FRILL_PLANE

/obj/structure/sign/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount, plane, plane)

/obj/structure/sign/desc_chaser(mob/user)
	. = ..()
	var/icon_src = icon2html(src, world, dir = SOUTH, sourceonly = TRUE)
	. += "<div style='text-align:center;'><img src='[icon_src]' width=96 height=96></div>"
