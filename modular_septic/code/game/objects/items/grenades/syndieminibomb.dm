/obj/item/grenade/frag
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "frag"

/obj/item/grenade/frag/pipebomb
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "ted"
	drop_sound = list('modular_septic/sound/weapons/flash1.wav', 'modular_septic/sound/weapons/flash2.wav')
	pipebomb = TRUE

/obj/item/grenade/frag/pipebomb/attack_self(mob/user)
	if(HAS_TRAIT(src, TRAIT_NODROP))
		to_chat(user, span_notice("You try prying [src] off your hand..."))
		if(do_after(user, 7 SECONDS, target=src))
			to_chat(user, span_notice("You manage to remove [src] from your hand."))
			REMOVE_TRAIT(src, TRAIT_NODROP, STICKY_NODROP)
		return

/obj/item/grenade/frag/pipebomb/attackby(obj/item/I, mob/user, params)
	if(I.get_temperature() && !active)
		if(!botch_check(user)) // if they botch the prime, it'll be handled in botch_check
			arm_grenade(user)
			to_chat(user, span_info("You light the fuse on the [src]"))
			icon_state = "ted_lit"
			log_bomber(user, "seems to be committing an act of intellectual anprim genocide!")
