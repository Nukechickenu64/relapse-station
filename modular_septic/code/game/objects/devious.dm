/obj/item/deviouslick
	var/lickable = TRUE
	var/tiktok_accepted = TRUE

/obj/item/deviouslick/sounding
	name = "Sounding Rod"
	desc = "UUUUUUUUUUUUUUUUUA\
			\nAUUUUUUUUUUUUUUUUUUUUUUUUU"
	icon = 'modular_septic/icons/obj/items/deviouslick.dmi'
	icon_state = "OOOOOOO"
	inhand_icon_state = "buildpipe"
	var/uuuua = FALSE
	var/doing_animation = FALSE

/obj/item/deviouslick/sounding/attack_self(mob/user, modifiers)
	. = ..()
	if(doing_animation)
		return
	uuuua = !uuuua
	var/sound_to_play
	//make uuuuuuua sound
	if(uuuua)
		sound_to_play = 'modular_septic/sound/memeshit/uuua.ogg'
	else
		sound_to_play = 'modular_septic/sound/memeshit/auuu.ogg'
	INVOKE_ASYNC(src, .proc/do_sounding, sound_to_play)

/obj/item/deviouslick/sounding/proc/do_sounding(sound_to_play = 'modular_septic/sound/memeshit/uuua.ogg')
	doing_animation = TRUE
	var/matrix/original_transform = matrix(transform)
	var/matrix/half_flipped_matrix = original_transform.Turn(90)
	var/matrix/flipped_matrix = half_flipped_matrix.Turn(90)
	animate(src, transform = half_flipped_matrix, time = 0.5 SECONDS)
	sleep(0.5 SECONDS)
	animate(src, transform = flipped_matrix, time = 0.5 SECONDS)
	sleep(1 SECONDS)
	transform = original_transform
	icon_state = "UAAAAAAAAA"
	playsound(src, sound_to_play, 75, FALSE)
	//this sleeps for a bit more than the animation lasts for
	sleep(1.5 SECONDS)
	doing_animation = FALSE
	icon_state = initial(icon_state)

/obj/item/deviouslick/soapdispenser
	name = "Soap Dispensed"
	desc = "<b>DEVIOUS.</b>"
	icon = 'modular_septic/icons/obj/items/deviouslick.dmi'
	icon_state = "soapdispenser"

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
	var/obj/item/deviouslick/soapdispenser/stored_soapdispenser

/obj/structure/soapmount/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(ndir)
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -27 : 27)
		pixel_y = (dir & 3)? (dir ==1 ? -30 : 30) : 0
		icon_state = "soapmount_empty"
	else
		stored_soapdispenser = new /obj/item/deviouslick/soapdispenser(src)

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

/obj/structure/soapmount/deviouslick/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/structure/soapmount/deviouslick/directional/south
	dir = NORTH
	pixel_y = -32

/obj/structure/soapmount/deviouslick/directional/east
	dir = WEST
	pixel_x = 32

/obj/structure/soapmount/deviouslick/directional/west
	dir = EAST
	pixel_x = -32
