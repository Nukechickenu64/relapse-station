/obj/item/gun/ballistic/revolver
	icon = 'modular_septic/icons/obj/items/guns/revolver.dmi'
	icon_state = "revolver"
	base_icon_state = "revolver"
	uncocked_icon_state = TRUE
	cylinder_shows_open = TRUE
	cylinder_shows_ammo_count = TRUE
	safety_flags = NONE
	bolt_type = BOLT_TYPE_BREAK_ACTION
	bolt_wording = "hammer"
	cylinder_wording = "cylinder"
	semi_auto = TRUE
	initial_caliber = CALIBER_357
	alternative_caliber = CALIBER_38
	alternative_ammo_misfires = FALSE
	// close cylinder sound
	lock_back_sound = 'modular_septic/sound/weapons/guns/revolver/cylinder_in.ogg'
	// open cylinder sound
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/revolver/cylinder_out.ogg'
	// hammer sound
	rack_sound = 'modular_septic/sound/weapons/guns/revolver/hammer1.ogg'
	fire_sound = 'modular_septic/sound/weapons/guns/revolver/revolver_fire.ogg'
	alternative_fire_sound = 'modular_septic/sound/weapons/guns/revolver/revolver_fire.ogg'
	equip_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_holster.wav'
	pickup_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_draw.wav'
	gunshot_animation_information = list("pixel_x" = 12, \
										"pixel_y" = 5)
	recoil_animation_information = list("recoil_angle_upper" = -25,
										"recoil_angle_lower" = -50)
	w_class = WEIGHT_CLASS_NORMAL
	carry_weight = 1.5
	skill_melee = SKILL_IMPACT_WEAPON
	skill_ranged = SKILL_PISTOL

/obj/item/gun/ballistic/revolver/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //mature var names for mature people //What If I'm a child?
	if(magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/revolver/chamber_examine(mob/user)
	. = ..()
	if(current_skin || !length(unique_reskin))
		. += "The [cylinder_wording] can be spun with <b>alt+click</b>"

/obj/item/gun/ballistic/revolver/remis

// CATTLE REVOLVER
/obj/item/gun/ballistic/revolver/remis/gado
	name = "\improper Revolver de Gado"
	desc = "An efficient revolver with multiple new systems in-place, if the hammer wasn't enough, there's now a safety exclusively for people who put the gun in their holster way too fast and shoot their own damn leg. \
			It has a unique system for the hammer and cylinder. It's used for slaughtering cattle."
	icon_state = "bladerunner"
	base_icon_state = "bladerunner"
	uncocked_icon_state = FALSE
	fire_sound = list('modular_septic/sound/weapons/guns/revolver/gado1.wav', 'modular_septic/sound/weapons/guns/revolver/gado3.wav', 'modular_septic/sound/weapons/guns/revolver/gado3.wav')
	safety_on_sound = 'modular_septic/sound/weapons/guns/revolver/gado_safetyon.ogg'
	safety_off_sound = 'modular_septic/sound/weapons/guns/revolver/gado_safetyon.ogg'
	gunshot_animation_information = list("pixel_x" = 13, \
										"pixel_y" = 3)
	recoil_animation_information = list("recoil_angle_upper" = -25,
										"recoil_angle_lower" = -50)
	safety_flags = GUN_SAFETY_HAS_SAFETY | GUN_SAFETY_ENABLED | GUN_SAFETY_OVERLAY_ENABLED | GUN_SAFETY_OVERLAY_ENABLED | GUN_SAFETY_OVERLAY_DISABLED
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/gado
	carry_weight = 2

// NAMBU REVOLVER
/obj/item/gun/ballistic/revolver/remis/nova
	name = "\improper Nova Seguranca M62 revolver"
	desc = "A stained, antique revolver with an unknown insignia on the side."
	icon_state = "newnambu"
	base_icon_state = "newnambu"
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_righthand.dmi'
	inhand_icon_state = "newnambu"
	gunshot_animation_information = list("pixel_x" = 13, \
										"pixel_y" = 3)
	recoil_animation_information = list("recoil_angle_upper" = -25,
										"recoil_angle_lower" = -50)
	fire_sound = 'modular_septic/sound/weapons/guns/revolver/nova.ogg'
	alternative_fire_sound = 'modular_septic/sound/weapons/guns/revolver/nova.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/nova
	can_modify_ammo = TRUE
	initial_caliber = CALIBER_38
	alternative_caliber = CALIBER_357
	carry_weight = 1.5
