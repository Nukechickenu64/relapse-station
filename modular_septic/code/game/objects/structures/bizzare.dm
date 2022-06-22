/obj/structure/trickysign
	name = "loose warning sign"
	desc = "A sign depicting a symbol of pure warning and anxiety. It's loose enough to be pulled out of the ground If you're reliably strong or crazy enough."
	icon = 'modular_septic/icons/obj/structures/bizzare.dmi'
	icon_state = "tricky"
	anchored = TRUE
	density = TRUE
	var/obj/item/trickysign/trickysign = /obj/item/trickysign

/obj/structure/trickysign/Initialize(mapload)
	. = ..()
	trickysign = new trickysign(src)

/obj/structure/trickysign/proc/check_for_no_sign()
	if(trickysign == null|!trickysign)
		qdel(src)

/obj/structure/trickysign/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	try_to_rip()

/obj/structure/trickysign/proc/try_to_rip(mob/user)
	to_chat(user, span_notice("You grab [src] firmly..."))
	if(!do_after(user, 2 SECONDS * (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) > 11)))
		to_chat(user, span_warning("I need to stand still while I'm doing this, I'm a fucking retard!"))
		return
	user.transferItemToLoc(trickysign, user.loc)
	user.put_in_hands(trickysign)
	trickysign = null
	playsound(src, 'modular_septic/sound/weapons/melee/sign_rip.wav', 70, FALSE)
	to_chat(user, span_danger("I rip the sign straight out of the ground! Lucky me now I have a fucking sign what are they going to do about it?"))

