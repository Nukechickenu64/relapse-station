/obj/item/deviouslick
	var/lickable = TRUE
	var/tiktok_accepted = TRUE

/obj/item/deviouslick/sounding
	name = "Sounding Rod"
	desc = "UUUUUUUUUUUUUUUUUA \
	AUUUUUUUUUUUUUUUUUUUUUUUUU"

/obj/structure/soapmount
	name = "Soap Dispenser mount"
	desc = "A mount for a soap dispenser. Commonly seen in buisnesses, schools, malls and pools. Basically everywhere that has a bathroom, you'd have one of these. \
	Your peers would be disappointed in you If you did a <b>devious lick.</b>"
	icon = 'modular_septic/icons/obj/structures/deviouslick.dmi'
	icon_state = "soapmount_occupied"
	anchored = TRUE
	density = FALSE
	max_integrity = 420
	integrity_failure = 0.25

/obj/structure/soapmount/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(ndir)
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -27 : 27)
		pixel_y = (dir & 3)? (dir ==1 ? -30 : 30) : 0
		opened = TRUE
		icon_state = "soapmount_empty"
	else
		stored_extinguisher = new /obj/item/extinguisher(src)

/obj/structure/soapmount/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/structure/soapmount/directional/south
	dir = NORTH
	pixel_y = -32

/obj/structure/soapmount/directional/east
	dir = WEST
	pixel_x = 32

/obj/structure/soapmount/directional/west
	dir = EAST
	pixel_x = -32

/obj/structure/soapmount/deviouslick
	max_integrity = 99420
	lickable = TRUE
	tiktok_accepted = TRUE
