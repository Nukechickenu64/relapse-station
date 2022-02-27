// all pistols
/obj/item/gun/ballistic/automatic/pistol
	fire_delay = 1
	carry_weight = 1
	carry_weight = 0.8
	safety_off_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_safety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_safety.wav'
	skill_melee = SKILL_IMPACT_WEAPON
	skill_ranged = SKILL_PISTOL
	suppressed = SUPPRESSED_NONE

// RUGER MKIV
/obj/item/gun/ballistic/automatic/pistol
	name = "\improper Plinker pistol"
	desc = "A small, easily concealable 9mm handgun. Has a threaded barrel for suppressors."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "ruger"
	base_icon_state = "ruger"
	pickup_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_draw.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_lockback.wav'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_lockin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magout.wav'
	eject_sound_vary = FALSE
	rack_sound_vary = FALSE
	load_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magin.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_rack.wav'
	gunshot_animation_information = list("pixel_x" = 15, \
										"pixel_y" = 1, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	suppressor_x_offset = 10
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1
	custom_price = 3000

// BERETTA 69R
/obj/item/gun/ballistic/automatic/pistol/aps
	name = "\improper 69R machine pistol"
	desc = "A machine pistol made by some crazy italians, capable of shooting in 3-round bursts. \
		Uses 9mm ammo. Has a threaded barrel for suppressors."
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/aps.ogg'
	load_sound = 'modular_septic/sound/weapons/guns/pistol/aps_magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/pistol/aps_magin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/pistol/aps_magout.ogg'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/pistol/aps_magout.ogg'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/aps_lockback.wav'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/aps_lockin.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/aps_rack.ogg'
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "b93r"
	base_icon_state = "b93r"
	gunshot_animation_information = list("pixel_x" = 15, \
										"pixel_y" = 2, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30, \
										"recoil_burst_speed" = 0.5, \
										"return_burst_speed" = 0.5)
	suppressor_x_offset = 11
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1.5
	custom_price = 4500

// M1911
/obj/item/gun/ballistic/automatic/pistol/m1911
	name = "\improper M1911"
	desc = "A classical copy of a antique design, even centuries later is efficient for close-quarter combat and self-defence at the cost of magazine capacity."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "m1911"
	base_icon_state = "m1911"
	gunshot_animation_information = list("pixel_x" = 16, \
										"pixel_y" = 2)
	recoil_animation_information = list()
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/colt1.wav'
	force = 10
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1
	custom_price = 3500

// STI 2011 COMBAT MASTER
/obj/item/gun/ballistic/automatic/pistol/combatmaster
	name = "\improper Frag Master 2511"
	desc = "An expensive, reliable handgun with a large magazine capacity. \
			Very similar to the Cold 1911, but chambered in 9mm and made with modern materials such as a polymer handle and titanium frame."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "combatmaster"
	base_icon_state = "combatmaster"
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/combatmaster.wav'
	suppressed_sound = list('modular_septic/sound/weapons/guns/pistol/combatmaster_silenced1.wav', \
	'modular_septic/sound/weapons/guns/pistol/combatmaster_silenced2.wav')
	gunshot_animation_information = list("pixel_x" = 15, \
										"pixel_y" = 1, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	force = 10
	suppressor_x_offset = 12
	mag_type = /obj/item/ammo_box/magazine/combatmaster9mm
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1
	custom_price = 4500

// GLOCK-17
/obj/item/gun/ballistic/automatic/pistol/glock17
	name = "\improper Gosma-17 9mm pistol"
	desc = "A chunky pistol often accompanied with the screams of thugs."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "glock"
	base_icon_state = "glock"
	fire_sound = list('modular_septic/sound/weapons/guns/pistol/glock1.wav', \
					'modular_septic/sound/weapons/guns/pistol/glock2.wav')
	suppressed_sound = list('modular_septic/sound/weapons/guns/pistol/glock_suppressed1.wav', \
					'modular_septic/sound/weapons/guns/pistol/glock_suppressed2.wav')
	gunshot_animation_information = list("pixel_x" = 15, \
										"pixel_y" = 5)
	recoil_animation_information = list("recoil_angle_upper" = -20, \
										"recoil_angle_lower" = -35)
	force = 10
	mag_type = /obj/item/ammo_box/magazine/glock9mm
	mag_display = TRUE
	can_suppress = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1
	custom_price = 2500
	suppressor_x_offset = 10


// WALTHER PPK
/obj/item/gun/ballistic/automatic/pistol/ppk
	name = "\improper Bombeiro 22lr pistol"
	desc = "The Walter Bomberio pistol is a reliable, easily concealable 22lr pistol. \
			Doesn't pack too much of a punch, but was famously used by a british secret agent."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	icon_state = "ppk"
	base_icon_state = "ppk"
	fire_sound = list('modular_septic/sound/weapons/guns/pistol/walter1.wav',
					'modular_septic/sound/weapons/guns/pistol/walter2.wav')
	safety_on_sound = 'modular_septic/sound/weapons/guns/pistol/walter_safety.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/pistol/walter_safety.wav'
	gunshot_animation_information = list("pixel_x" = 11, \
										"pixel_y" = 1, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -10, \
										"recoil_angle_lower" = -20)
	mag_type = /obj/item/ammo_box/magazine/ppk22lr
	mag_display = TRUE
	can_suppress = FALSE
	w_class = WEIGHT_CLASS_SMALL
	carry_weight = 0.5
	custom_price = 900

/obj/item/gun/ballistic/automatic/pistol/remis

// Shrimp
/obj/item/gun/ballistic/automatic/pistol/remis/shrimp
	name = "\improper Camarao 1"
	desc = "A utility handgun used for the utility of shooting heavily armored targets multiple times in the eyes and face. \
	Sometimes in the groin, too..."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_righthand.dmi'
	inhand_icon_state = "sr1"
	icon_state = "sr1"
	base_icon_state = "sr1"
	gunshot_animation_information = list("pixel_x" = 16, \
										"pixel_y" = 2)
	recoil_animation_information = list()
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/gyzra.wav'
	force = 8
	mag_type = /obj/item/ammo_box/magazine/shrimp9x21
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1
	custom_price = 4500

// Five-Seven
/obj/item/gun/ballistic/automatic/pistol/remis/fiveseven
	name = "\improper Cinquenta e Sete"
	desc = "A premium firearm shooting a miniature rifle cartridge to combat intermediate ballistic protection."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_righthand.dmi'
	inhand_icon_state = "five7"
	icon_state = "five7"
	base_icon_state = "five7"
	gunshot_animation_information = list("pixel_x" = 16, \
										"pixel_y" = 2)
	recoil_animation_information = list()
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/fiveseven.wav'
	force = 10
	mag_type = /obj/item/ammo_box/magazine/five57
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1
	custom_price = 5500

	// Five-Seven
/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador
	name = "\improper Aniquilador .50 LE Anti-Personnel Firearm"
	desc = "A very rare firearm that can be found within experimental military bases, comes loaded with .50 LE, Living Exterminator rounds. \
		Feeling the gun in your hand, he never stops nervously shaking and vibrating until you aim down the sights at a living being."
	icon = 'modular_septic/icons/obj/items/guns/pistol.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_righthand.dmi'
	inhand_icon_state = "five7"
	icon_state = "aniquilador"
	base_icon_state = "aniquilador"
	gunshot_animation_information = list("pixel_x" = 16, \
										"pixel_y" = 2)
	recoil_animation_information = list()
	fire_sound = 'modular_septic/sound/weapons/guns/pistol/one.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/pistol/one_rack.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/pistol/one_lockback.wav'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/pistol/one_lockin.wav'
	aim_stress_sound = list('modular_septic/sound/weapons/guns/pistol/voice_anaquilador/anaquilador_getout.wav',
						'modular_septic/sound/weapons/guns/pistol/voice_anaquilador/anaquilador_noescape.wav')
	aim_spare_sound = 'modular_septic/sound/weapons/guns/rifle/voice_steyr/spare.wav'
	force = 10
	fire_delay = 8
	mag_type = /obj/item/ammo_box/magazine/aniquilador
	w_class = WEIGHT_CLASS_NORMAL
	can_unsuppress = FALSE
	verb_say = "ravishes"
	carry_weight = 2
	custom_price = 5500

/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_GUNPOINT_GUN_AIM_STRESS_SOUNDED, .proc/aimed_sounding)

/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador/Destroy()
	UnregisterSignal(src, COMSIG_GUNPOINT_GUN_AIM_STRESS_SOUNDED)
	return ..()

/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador/proc/aimed_sounding(datum/component/gunpoint/gunpoint, sounding)
	var/voice_line = "NIGGERS!"
	switch(sounding)
		if('modular_septic/sound/weapons/guns/pistol/voice_anaquilador/anaquilador_getout.wav')
			voice_line = "GET OUT FREAK."
		if('modular_septic/sound/weapons/guns/pistol/voice_anaquilador/anaquilador_noescape.wav')
			voice_line = "THERE IS NO ESCAPE."
	if(voice_line)
		say(voice_line)
	INVOKE_ASYNC(src, .proc/we_do_a_little_shaking)

/obj/item/gun/ballistic/automatic/pistol/remis/aniquilador/proc/we_do_a_little_shaking(intensity = 4, time_in = 2, time_out = 2, loops = 3)
	for(var/i in 1 to loops)
		animate(src, pixel_x = pixel_x + intensity, time = time_in)
		sleep(time_in)
		animate(src, pixel_x = pixel_x - intensity, time = time_out)
		sleep(time_out)
