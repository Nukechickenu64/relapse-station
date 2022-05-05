/obj/item/gun/energy
	///rape correction needed :anger:
	///empty alarm sound (if enabled)
	var/empty_alarm_sound = 'sound/weapons/gun/general/empty_alarm.ogg'
	///empty alarm volume sound
	var/empty_alarm_volume = 100
	///whether empty alarm sound varies
	var/empty_alarm_vary = TRUE

	///Whether the gun alarms when empty or not.
	var/empty_alarm = FALSE

/obj/item/gun/energy/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	. = ..()
	postfire_empty_checks(.)

/obj/item/gun/energy/add_weapon_description()
	AddElement(/datum/element/weapon_description, .proc/add_notes_gun)

/obj/item/gun/energy/proc/postfire_empty_checks(last_shot_succeeded = FALSE)
	if(!chambered && last_shot_succeeded)
		if(empty_alarm)
			playsound(src, empty_alarm_sound, empty_alarm_volume, empty_alarm_vary)
