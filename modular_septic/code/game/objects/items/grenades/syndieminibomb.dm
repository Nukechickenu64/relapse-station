/obj/item/grenade/syndieminibomb
	desc = "A CMIA manufactured explosive for destruction and demolition. Comes compacted and expands when the button on the top is pressed."
	name = "CMIA minibomb"
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "syndicate"
	base_icon_state = "syndicate"
	inhand_icon_state = "flashbang"
	worn_icon_state = "minibomb"
	pin_sound = 'modular_septic/sound/weapons/bomb_pin.wav'
	spoon_loud = FALSE
	spoon_sound = null
	pickup_sound = null
	ex_dev = 1
	ex_heavy = 2
	ex_light = 4
	ex_flame = 2
	grenade_flags = GRENADE_BUTTONED
	det_time = 5 SECONDS
	var/datum/looping_sound/syndieminibomb/soundloop

/obj/item/grenade/syndieminibomb/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)

/obj/item/grenade/syndieminibomb/Destroy()
	. = ..()
	QDEL_NULL(soundloop)

/obj/item/grenade/syndieminibomb/arm_grenade(mob/user, delayoverride, msg = TRUE, volume = 60)
	. = ..()
	if(active)
		flick("[base_icon_state]_open", src)
		sleep(1.3)
		icon_state = "[initial(icon_state)]_active"
		annoying_fucking_beeping()

/obj/item/grenade/syndieminibomb/proc/annoying_fucking_beeping()
	if(active)
		soundloop.start()
	else
		soundloop.stop()

/obj/item/grenade/frag
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "frag"
	base_icon_state = "frag"
	shrapnel_type = /obj/projectile/bullet/shrapnel
	shrapnel_radius = 4
	grenade_flags = GRENADE_PINNED|GRENADE_VISIBLE_PIN|GRENADE_VISIBLE_SPOON
	det_time = 1.5 SECONDS

/obj/item/grenade/frag/impact
	name = "impact grenade"
	desc = "A low yield grenade that is designed to detonate on thrown impact. Will not explode when dropped, or placed."
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "impactgrenade"
	base_icon_state = "impactgrenade"
	shrapnel_type = null
	det_time = 3
	ex_heavy = 0
	ex_light = 3
	ex_flame = 2

/obj/item/grenade/frag/pipebomb
	icon = 'modular_septic/icons/obj/items/grenade.dmi'
	icon_state = "ted"
	base_icon_state = "ted"
	pin_sound = 'modular_septic/sound/effects/flare_start.wav'
	spoon_loud = FALSE
	pickup_sound = null
	grenade_flags = GRENADE_FUSED
	det_time = 2 SECONDS
