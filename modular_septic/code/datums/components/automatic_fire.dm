#define AUTOFIRE_MOUSEUP 0
#define AUTOFIRE_MOUSEDOWN 1

/datum/component/automatic_fire

/datum/component/automatic_fire/Initialize(_autofire_shot_delay)
	. = ..()
	var/obj/item/gun = parent
	if(istype(gun, /obj/item/gun/ballistic/automatic) && !(/datum/action/item_action/toggle_firemode in gun.actions_types))
		new /datum/action/item_action/toggle_firemode(gun)

/datum/component/automatic_fire/start_autofiring()
	if(autofire_stat == AUTOFIRE_STAT_FIRING)
		return
	autofire_stat = AUTOFIRE_STAT_FIRING

	clicker.mouse_override_icon = 'modular_septic/icons/effects/mouse_pointers/weapon_pointer_auto.dmi'
	shooter.update_mouse_pointer()

	if(mouse_status == AUTOFIRE_MOUSEUP) //See mouse_status definition for the reason for this.
		RegisterSignal(clicker, COMSIG_CLIENT_MOUSEUP, .proc/on_mouse_up)
		mouse_status = AUTOFIRE_MOUSEDOWN

	RegisterSignal(shooter, COMSIG_MOB_SWAP_HANDS, .proc/stop_autofiring)

	if(isgun(parent))
		var/obj/item/gun/gun = parent
		//This is needed because the minigun has a do_after before firing and signals are async
		if(!gun.on_autofire_start(shooter))
			stop_autofiring()
			return
	if(autofire_stat != AUTOFIRE_STAT_FIRING)
		return //Things may have changed while on_autofire_start() was being processed, due to do_after's sleep.

	if(!process_shot()) //First shot is processed instantly.
		return //If it fails, such as when the gun is empty, then there's no need to schedule a second shot.

	START_PROCESSING(SSprojectiles, src)
	RegisterSignal(clicker, COMSIG_CLIENT_MOUSEDRAG, .proc/on_mouse_drag)

/datum/component/automatic_fire/stop_autofiring(datum/source, atom/object, turf/location, control, params)
	if(autofire_stat != AUTOFIRE_STAT_FIRING)
		return
	STOP_PROCESSING(SSprojectiles, src)
	autofire_stat = AUTOFIRE_STAT_ALERT
	if(clicker)
		clicker.mouse_override_icon = null
		clicker.mouse_pointer_icon = clicker.mouse_override_icon
		UnregisterSignal(clicker, COMSIG_CLIENT_MOUSEDRAG)
	if(!QDELETED(shooter))
		UnregisterSignal(shooter, COMSIG_MOB_SWAP_HANDS)
		shooter.update_mouse_pointer()
	target = null
	target_loc = null
	mouse_parameters = null

/obj/item/gun/on_autofire_start(mob/living/shooter)
	if(semicd || shooter.stat)
		return FALSE
	//Check if the user can use the gun, if the user isn't alive (turrets) assume it can.
	if(istype(shooter))
		before_trigger_checks(shooter, TRUE)
		if(!can_trigger_gun(shooter))
			shoot_with_empty_chamber(shooter)
			return NONE
	//Just because you can pull the trigger doesn't mean it can shoot.
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return NONE
	//Weapon is heavy but isn't wielded
	if((weapon_weight >= WEAPON_HEAVY) && !SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
		to_chat(shooter, span_warning("I need two hands to fire [src]!"))
		return NONE
	//Weapon is heavy but isn't wielded
	if((weapon_weight >= WEAPON_HEAVY) && !SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
		to_chat(shooter, span_warning("I need two hands to fire [src]!"))
		return FALSE
	return TRUE

/obj/item/gun/do_autofire(datum/source, atom/target, mob/living/shooter, params)
	if(semicd || shooter.stat)
		return NONE
	//Check if the user can use the gun, if the user isn't alive (turrets) assume it can.
	if(istype(shooter))
		before_trigger_checks(shooter)
		if(!can_trigger_gun(shooter))
			shoot_with_empty_chamber(shooter)
			return NONE
	//Just because you can pull the trigger doesn't mean it can shoot.
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return NONE
	//Weapon is heavy but isn't wielded
	if((weapon_weight >= WEAPON_HEAVY) && !SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
		to_chat(shooter, span_warning("I need two hands to fire [src]!"))
		return NONE
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return NONE
	INVOKE_ASYNC(src, .proc/do_autofire_shot, source, target, shooter, params)
	return COMPONENT_AUTOFIRE_SHOT_SUCCESS //All is well, we can continue shooting.

/obj/item/gun/ballistic/automatic/on_autofire_start(mob/living/shooter)
	if(semicd || shooter.stat)
		return NONE
	//Not on full auto silly goose!
	if(select != 3)
		return NONE
	//Check if the user can use the gun, if the user isn't alive (turrets) assume it can.
	if(istype(shooter))
		before_trigger_checks(shooter, TRUE)
		if(!can_trigger_gun(shooter))
			shoot_with_empty_chamber(shooter)
			return NONE
	//Just because you can pull the trigger doesn't mean it can shoot.
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return NONE
	//Weapon is heavy but isn't wielded
	if((weapon_weight >= WEAPON_HEAVY) && !SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
		to_chat(shooter, span_warning("I need two hands to fire [src]!"))
		return NONE
	//Weapon is heavy but isn't wielded
	if((weapon_weight >= WEAPON_HEAVY) && !SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
		to_chat(shooter, span_warning("I need two hands to fire [src]!"))
		return FALSE
	return TRUE

/obj/item/gun/ballistic/automatic/do_autofire(datum/source, atom/target, mob/living/shooter, params)
	if(semicd || shooter.stat)
		return NONE
	//Not on full auto silly goose!
	if(select != 3)
		return NONE
	//Check if the user can use the gun, if the user isn't alive (turrets) assume it can.
	if(istype(shooter))
		before_trigger_checks(shooter)
		if(!can_trigger_gun(shooter))
			shoot_with_empty_chamber(shooter)
			return NONE
	//Just because you can pull the trigger doesn't mean it can shoot.
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return NONE
	//Weapon is heavy but isn't wielded
	if((weapon_weight >= WEAPON_HEAVY) && !SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
		to_chat(shooter, span_warning("I need two hands to fire [src]!"))
		return NONE
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return NONE
	INVOKE_ASYNC(src, .proc/do_autofire_shot, source, target, shooter, params)
	return COMPONENT_AUTOFIRE_SHOT_SUCCESS //All is well, we can continue shooting.

#undef AUTOFIRE_MOUSEUP
#undef AUTOFIRE_MOUSEDOWN
