/obj/structure/sign
	icon = 'modular_septic/icons/obj/decals.dmi'

/obj/structure/sign/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount)

/obj/structure/sign/desc_chaser(mob/user)
	. = ..()
	var/icon_src = icon2html(src, world, dir = SOUTH, sourceonly = TRUE)
	. += "<div class='infobox' margin='auto'><img src='[icon_src]' width=96 height=96></div>"
