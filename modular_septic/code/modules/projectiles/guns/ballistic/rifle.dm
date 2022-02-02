/obj/item/gun/ballistic/automatic/remis
	rack_sound_vary = FALSE
	suppressed = SUPPRESSED_NONE
	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	mag_display = TRUE
	mag_display_ammo = FALSE
	empty_indicator = FALSE
	empty_icon_state = TRUE
	wielded_inhand_state = TRUE
	weapon_weight = WEAPON_HEAVY
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	skill_ranged = SKILL_RIFLE

// Winter Genocide Nigga Killer-49
/obj/item/gun/ballistic/automatic/remis/winter
	name = "\improper Inverno Genocídio NK-49 Assault Rifle"
	desc = "Inverno Genocídio, 'Winter Genocide' Assault Rifle firing in 7.62, ordinator-issue high-power rifles used for Military and Extreme Law Enforcement."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_righthand.dmi'
	inhand_icon_state = "inverno"
	icon_state = "inverno"
	base_icon_state = "inverno"
	mag_type = /obj/item/ammo_box/magazine/a762winter
	actions_types = null
	burst_size = 1
	select = FALSE
	fire_sound = 'modular_septic/sound/weapons/guns/rifle/niggakiller.wav'
	load_sound = 'modular_septic/sound/weapons/guns/rifle/mmagin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/rifle/mmagin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/rifle/mmagout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/rifle/mmagout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/mrack.wav'
	force = 14
	custom_price = 45000
	carry_weight = 3
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -25)

/obj/item/gun/ballistic/automatic/remis/winter/pickup(mob/user)
	. = ..()
	user.client?.give_award(/datum/award/achievement/misc/niggerkiller, user)

//Darkworld Gun
/obj/item/gun/ballistic/automatic/remis/abyss
	name = "\improper AN-94 5.4539mm Abyss Assault Rifle"
	desc = "A mysterious rifle chambered in a forgotten cartridge. The rifle doesn't seem to have any serial number, making It untraceable. \
		The muzzle brake seems to be compatable with noise suppressors."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_righthand.dmi'
	inhand_icon_state = "nikonov"
	icon_state = "nikonov"
	base_icon_state = "nikonov"
	mag_type = /obj/item/ammo_box/magazine/a54539abyss
	fire_sound = 'modular_septic/sound/weapons/guns/rifle/ak.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/rifle/ak_silenced.wav'
	load_sound = 'modular_septic/sound/weapons/guns/rifle/akmagin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/rifle/akmagin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/rifle/akmagout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/rifle/akmagout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety1.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/akrack.wav'
	force = 16
	fire_delay = 2
	burst_size = 2
	can_suppress = TRUE
	suppressor_x_offset = 10
	gunshot_animation_information = list("pixel_x" = 32, \
										"pixel_y" = 3, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -10, \
										"recoil_angle_lower" = -20)
	custom_price = 30000

/obj/item/gun/ballistic/automatic/remis/g11
	name = "\improper Guloseima 4.92x34mm Prototype Assault Rifle"
	desc = "An oddly chunky assault rifle chambered in caseless 4.92x34mm. \
		Never seen before in this region, how'd you get your hands on this?"
	icon = 'modular_septic/icons/obj/items/guns/40x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_righthand.dmi'
	inhand_icon_state = "g11"
	icon_state = "g11"
	base_icon_state = "g11"
	mag_type = /obj/item/ammo_box/magazine/a49234g11
	fire_sound = 'modular_septic/sound/weapons/guns/rifle/g11.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/rifle/g11_silenced.wav'
	load_sound = 'modular_septic/sound/weapons/guns/rifle/g11magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/rifle/g11magin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/rifle/g11magout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/rifle/g11magout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety1.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/g11rack.wav'
	force = 12
	fire_delay = 0.7
	burst_size = 3
	can_suppress = FALSE
	custom_price = 20000
	gunshot_animation_information = list("pixel_x" = 21, \
										"pixel_y" = -1, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -10, \
										"recoil_angle_lower" = -20, \
										"recoil_burst_speed" = 0.5, \
										"return_burst_speed" = 0.5)

//copypasted just to ensure that we can nuke the casing
/obj/item/gun/ballistic/automatic/remis/g11/handle_chamber(empty_chamber, from_firing, chamber_next_round)
	if((!semi_auto && from_firing) || (bolt_type == BOLT_TYPE_BREAK_ACTION))
		return
	var/obj/item/ammo_casing/casing = chambered //Find chambered round
	if(istype(casing)) //there's a chambered round
		if(QDELING(casing))
			stack_trace("Trying to move a qdeleted casing of type [casing.type]!")
			chambered = null
		else
			//Casing gets ejected and immediately deleted (i couldn't make this casing specific behavior)
			casing.forceMove(drop_location())
			SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)
			if(!casing.loaded_projectile)
				qdel(casing)
			chambered = null
	if(chamber_next_round && (magazine?.max_ammo > 1))
		chamber_round()

/obj/item/gun/ballistic/automatic/remis/steyr
	name = "\improper Selo-Selo ACR Prototype Flechette-Firing Assault Rifle"
	desc = "A unique firearm that practically consists of one large piece with a barrel ran through the whole gun. Fires in steel-SCF Flechettes. \
		If you look hard enough, the entire gun seems to vibrate, and shake. It's almost like It's alive."
	gender = FEMALE
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_righthand.dmi'
	inhand_icon_state = "steyr"
	icon_state = "steyr"
	base_icon_state = "steyr"
	mag_type = /obj/item/ammo_box/magazine/a556steyr
	fire_sound = 'modular_septic/sound/weapons/guns/rifle/steyr.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/rifle/steyr_silenced.wav'
	load_sound = 'modular_septic/sound/weapons/guns/rifle/mmagin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/rifle/mmagin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/rifle/mmagout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/rifle/mmagout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/mrack.wav'
	aim_stress_sound = list('modular_septic/sound/weapons/guns/rifle/voice_steyr/canthide.wav',
						'modular_septic/sound/weapons/guns/rifle/voice_steyr/seeyou.wav',
						'modular_septic/sound/weapons/guns/rifle/voice_steyr/targetacquired.wav',
						'modular_septic/sound/weapons/guns/rifle/voice_steyr/runpig.wav')
	aim_spare_sound = 'modular_septic/sound/weapons/guns/rifle/voice_steyr/spare.wav'
	actions_types = null
	force = 12
	suppressor_x_offset = 8
	can_suppress = TRUE
	verb_say = "passionately whispers"
	gunshot_animation_information = list("pixel_x" = 29, \
										"pixel_y" = 0, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -10, \
										"recoil_angle_lower" = -20, \
										"recoil_burst_speed" = 0.5, \
										"return_burst_speed" = 0.5)
	custom_price = 80000

/obj/item/gun/ballistic/automatic/remis/steyr/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_GUNPOINT_GUN_AIM_STRESS_SOUNDED, .proc/aimed_sounding)

/obj/item/gun/ballistic/automatic/remis/steyr/Destroy()
	UnregisterSignal(src, COMSIG_GUNPOINT_GUN_AIM_STRESS_SOUNDED)
	return ..()

/obj/item/gun/ballistic/automatic/remis/steyr/proc/aimed_sounding(datum/component/gunpoint/gunpoint, sounding)
	var/voice_line = "NIGGERS!"
	switch(sounding)
		if('modular_septic/sound/weapons/guns/rifle/voice_steyr/canthide.wav')
			voice_line = "You can't hide."
		if('modular_septic/sound/weapons/guns/rifle/voice_steyr/seeyou.wav')
			voice_line = "I can see you."
		if('modular_septic/sound/weapons/guns/rifle/voice_steyr/targetacquired.wav')
			voice_line = "Target acquired."
		if('modular_septic/sound/weapons/guns/rifle/voice_steyr/runpig.wav')
			voice_line = "Run, pig."
	if(voice_line)
		say(voice_line)
	INVOKE_ASYNC(src, .proc/we_do_a_little_shaking)

/obj/item/gun/ballistic/automatic/remis/steyr/proc/we_do_a_little_shaking(intensity = 4, time_in = 2, time_out = 2, loops = 3)
	for(var/i in 1 to loops)
		animate(src, pixel_x = pixel_x + intensity, time = time_in)
		sleep(time_in)
		animate(src, pixel_x = pixel_x - intensity, time = time_out)
		sleep(time_out)


// 7.62x54R Lampiao sniper-rifle
/obj/item/gun/ballistic/automatic/remis/svd
	name = "\proper Lampiao semi-automatic designated marksman rifle"
	desc = "A Lampiao sniper-rifle firing in 7.62x54R, the design allows for comfortable medium and long range combat, and unconventional, but effective CQC against armored targets. \
	 Has a dovetail mount for a PSO-1M2-1 4x24 scope and a threaded barrel for a sound-suppressor. "
	icon = 'modular_septic/icons/obj/items/guns/64x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_righthand.dmi'
	inhand_icon_state = "svd"
	icon_state = "svd"
	base_icon_state = "svd"
	mag_type = /obj/item/ammo_box/magazine/a762svd
	actions_types = null
	burst_size = 1
	select = FALSE
	fire_sound = 'modular_septic/sound/weapons/guns/rifle/svd.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/rifle/svd_silenced.wav'
	load_sound = 'modular_septic/sound/weapons/guns/rifle/svdmagin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/rifle/svdmagin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/rifle/svdmagout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/rifle/svdmagout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety1.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/akrack.wav'
	force = 13
	carry_weight = 4
	custom_price = 30000
	recoil = 0.4
	can_suppress = TRUE
	suppressor_x_offset = 8
	gunshot_animation_information = list("pixel_x" = 43, \
										"pixel_y" = 2, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -18, \
										"recoil_angle_lower" = -25)

/obj/item/gun/ballistic/automatic/remis/g3
	name = "\proper \"Arma\" A3 semi-automatic designated marksman rifle"
	desc = "A 7.62x51mm semi-automatic firearm that uses a roller-delayed blowback operating system. Not well known within Nevado due to the heavy weight and expensive price."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_righthand.dmi'
	inhand_icon_state = "g3"
	icon_state = "g3"
	base_icon_state = "g3"
	mag_type = /obj/item/ammo_box/magazine/a762g3
	actions_types = null
	burst_size = 1
	select = FALSE
	fire_sound = 'modular_septic/sound/weapons/guns/rifle/g3.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/rifle/g3_silenced.wav'
	load_sound = 'modular_septic/sound/weapons/guns/rifle/svdmagin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/rifle/svdmagin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/rifle/svdmagout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/rifle/svdmagout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_rack.wav'
	force = 13
	carry_weight = 4
	custom_price = 40000
	recoil = 0.4
	can_suppress = TRUE
	suppressor_x_offset = 12
	gunshot_animation_information = list("pixel_x" = 58, \
										"pixel_y" = 17, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -18, \
										"recoil_angle_lower" = -25)
