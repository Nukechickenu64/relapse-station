
/obj/machinery/firealarm/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	if(obj_flags & EMAGGED || machine_stat)
		return FALSE
	var/turf/turf_loc = loc
	if(istype(turf_loc) && turf_loc.turf_fire)
		return TRUE
	if(exposed_temperature > T0C + 80 || exposed_temperature < T0C - 10)
		return TRUE

/obj/machinery/firealarm/alarm(mob/user, extrarange = 3)
	if(!is_operational || !COOLDOWN_FINISHED(src, last_alarm))
		return
	COOLDOWN_START(src, FIREALARM_COOLDOWN)
	var/area/area = get_area(src)
	area.firealert(src)
	playsound(loc, 'modular_septic/sound/misc/alarm.wav', 75, FALSE)
	if(user)
		log_game("[user] triggered a fire alarm at [COORD(src)]")
